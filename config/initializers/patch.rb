if defined?(ActiveSupport::JSON)
  [Object, Array, FalseClass, Float, Hash, Integer, NilClass, String, TrueClass].each do |klass|
    klass.class_eval do
      def to_json(*args)
        super(args)
      end
      def as_json(*args)
        super(args)
      end
    end
  end
end

def sidekiq_options(opts={})
  self.sidekiq_options_hash = get_sidekiq_options.merge(stringify_keys(opts || {}))
end

DEFAULT_OPTIONS = { 'retry' => true, 'queue' => 'default' }

def get_sidekiq_options # :nodoc:
  self.sidekiq_options_hash ||= DEFAULT_OPTIONS
end