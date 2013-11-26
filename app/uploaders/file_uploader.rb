# encoding: utf-8
require 'carrierwave/orm/activerecord'
class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::MimeTypes
  process :set_content_type

  #Extensions
  IMAGE_EXTENSIONS    = %w(jpg jpeg gif png)
  DOCUMENT_EXTENSIONS = %w(zip txt exe pdf doc docm xls)
  VIDEO_EXTENSIONS    = %w(avi quicktime 3gpp mp3 mp4 flv mpeg mov)

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

   

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # create a new "process_extensions" method.  It is like "process", except
  # it takes an array of extensions as the first parameter, and registers
  # a trampoline method which checks the extension before invocation
  def self.process_extensions(*args)
    extensions = args.shift
    args.each do |arg|
      if arg.is_a?(Hash)
        arg.each do |method, args|
          processors.push([:process_trampoline, [extensions, method, args]])
        end
      else
        processors.push([:process_trampoline, [extensions, arg, []]])
      end
    end
  end

  # Trampoline method which only performs processing if the extension matches
  def process_trampoline(extensions, method, args)
    extension = File.extname(original_filename).downcase
    extension = extension[1..-1] if extension[0,1] == '.'
    self.send(method, *args) if extensions.include?(extension)
  end

  process :store_geometry
  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     IMAGE_EXTENSIONS + DOCUMENT_EXTENSIONS + VIDEO_EXTENSIONS
   end

   version :big, :if => :image? do
    process :resize_to_fill => [760, nil]
   end
   
   version :thumb_big, :if => :image? do
    process :resize_to_fill => [200, 200]
   end

   version :thumb, :if => :image? do
    process :resize_to_fill => [160, 160]
   end

   version :tiny, :if => :image? do
    process :resize_to_fill => [40, 40]
   end




   protected

    def image?(new_file)
      new_file.content_type.include? 'image'
    end

    def store_geometry
      if image?(@file)
        img = ::Magick::Image::read(@file.file).first
        if model
          model.width = img.columns
          model.height = img.rows
        end
      end
    end





  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
