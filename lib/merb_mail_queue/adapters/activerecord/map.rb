module Merb
  module MailQueue
    module Adapters
      module ActiveRecord
        module Map
          
          def self.included(base)
            base.send(:include, InstanceMethods)
            base.send(:extend,  ClassMethods)
          end
      
          module InstanceMethods
          end
      
          module ClassMethods
            def load_queue(*args)
              find(:all, *args)
            end
            
            def queue(from, to, subject, text, html)
              [to].flatten.each do |recepient|
                create(:to => recepient, :from => from, :subject => subject, :text => text, :html => html)
              end
            end
          end # ClassMethods
          
        end # Map
      end # ActiveRecord
    end # Adapters
  end # MailQueue
end # Merb