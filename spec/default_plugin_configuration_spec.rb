require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) / '..' / "lib" / "merb_mail_queue"
Merb::MailQueue.load_plugin!

describe Merb::MailQueue, "default plugin configuration" do
  it "uses MailQueueJob as default model name" do
    Merb::Plugins.config[:merb_mail_queue][:mail_queue_job_model_class_name].should == "MailQueueJob"
  end
end