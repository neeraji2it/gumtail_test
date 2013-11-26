# == Schema Information
#
# Table name: file_handlers
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  product_id :integer          default(0)
#  is_cover   :boolean          default(FALSE)
#  file_name  :string(255)      not null
#  file_path  :string(255)      not null
#  file_type  :string(255)      not null
#  file_size  :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  properties :hstore
#

class FileHandler < ActiveRecord::Base
   serialize :properties, ActiveRecord::Coders::Hstore
   attr_accessible :product_id, :is_cover, :file_name, :file_path
   belongs_to :user
   mount_uploader :file_path, FileUploader
   before_save :update_file_attributes
   before_save :delete_previous_avatar
   after_save :update_avatar
   #before_destroy :remember_file
   #after_destroy :remove_file
   

  def update_file_attributes
    if file_path.present? && file_path_changed?
      self.file_name = file_path.file.filename
      self.file_type = file_path.file.content_type
      self.file_size = file_path.file.size
    end
  end

  def update_avatar
    if self.properties['klasss'] == "avatar_upload_button"
      User.update_all "avatar_id = #{self.id}", ['id = ?', self.user_id ]
    end
  end


  #Hstore
  %w[manual_type klasss width height].each do |key|
    attr_accessible key

    define_method(key) do
      properties && properties[key]
    end
  
    define_method("#{key}=") do |value|
      self.properties = (properties || {}).merge(key => value)
    end
  end


  protected
    def remember_file
      @file_name = self[:file_name]
      @file_id =   self[:id]
    end

    def remove_file
      File.delete("#{Rails.root}/public/file_handler/file_path/#{@file_id}/#{@file_name}")
      File.delete("#{Rails.root}/public/file_handler/file_path/#{@file_id}/thumb_#{@file_name}")
    end

    def delete_previous_avatar
      if self.properties['Klasss'] == "avatar_upload_button"
        aid = User.where("id= ? ", self.user_id).first.avatar_id
        FileHandler.delete(aid)
      end
    end

end

