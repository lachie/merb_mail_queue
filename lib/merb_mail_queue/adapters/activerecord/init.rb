require "activerecord"

module Merb
  module MailQueue
    module Adapters
      module ActiveRecord
        
      end
    end
  end
end

path = File.dirname(__FILE__)
require path / "map"

Merb::MailQueue.mail_queue_job_model_class.send(:include, Merb::MailQueue::Adapters::ActiveRecord::Map)