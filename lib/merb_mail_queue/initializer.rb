module Merb
  module Plugins
    class AdapterIsNotRegistred < StandardError
      def initialize(adapter)
        super("Adapter #{adapter} is not registred")
      end
    end
    
    class NoAdapterSpecified < StandardError
    end
  end
  
  module MailQueue

    def self.config
      Merb::Plugins.config[:merb_mail_queue]
    end
    
    def self.mail_queue_job_model_class
      Object.full_const_get(Merb::Plugins.config[:merb_mail_queue][:mail_queue_job_model_class_name])
    end

    # Clears the currently registered adapter list.  
    def self.clear_adapter_list!
      @_adapters = nil
    end
  
    # Registers an adapter.
    # @param [Symbol] name is the name of the adapter.  Supported adapters are :datamapper and :activerecord
    # @param [String] path is the path to the adapter.  The adapter path _directory_ should include an init.rb file
    # @param [Hash] opts an options hash
    def self.register_adapter(name, path, opts = {})
      adapters[name.to_sym] = opts.merge!(:path => path)
    end
  
    # @return [Hash] A hash of the adapters.  
    def self.adapters
      @_adapters ||= Hash.new{|h,k| h[k] = {}}
    end    
    
    # Loads the adapter provided, or if not provided, the adapter set in the slices config
    # @param [Symbol | String] adapter The name of the adapter to load.  This must be registered
    # @raise [RuntimeError] Raises an error if the adapter is not registered.
    def self.load_adapter!(adapter = nil)
      adapter ||= self.config[:adapter] || Merb.orm_generator_scope
      raise Merb::Plugins::NoAdapterSpecified if adapter.nil? || adapter.blank?
    
      # Check that the adapter is registered
      raise Merb::Plugins::AdapterIsNotRegistred.new(adapter) unless adapters.keys.include?(adapter.to_sym)
    
      if Merb.env?(:test)
        load adapters[adapter.to_sym][:path] / "init.rb"
      else
        require adapters[adapter.to_sym][:path] / "init"
      end
    end
    
    def self.load_plugin!
      Merb::Controller.send(:include, Merb::MailQueue::MailQueueMixin)
      Merb::MailController.send(:include, Merb::MailQueue::DispatchAndQueueMixin)
      Merb::MailQueue.load_adapter!(Merb::Plugins.config[:merb_mail_queue][:adapter])
    end
    
  end
end