# make sure we're running inside Merb
if defined?(Merb::Plugins)  
  require "merb-mailer"
  
  require File.dirname(__FILE__) / "merb_mail_queue" / "initializer"
  require File.dirname(__FILE__) / "merb_mail_queue" / "mail_queue_mixin"
  require File.dirname(__FILE__) / "merb_mail_queue" / "processor"
  
  adapter_path = File.dirname(__FILE__) / "merb_mail_queue" / "adapters"
  Merb::MailQueue.register_adapter :activerecord, "#{adapter_path}/activerecord"
  
  Merb::Plugins.config[:merb_mail_queue] = {
    :mail_queue_job_model_class_name => "MailQueueJob"
  }

  Merb::Plugins.add_rakefiles "merb_mail_queue/merbtasks"
end