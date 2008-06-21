require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) / '..' / "lib" / "merb_mail_queue"
Merb::MailQueue.load_plugin!

describe Merb::MailQueue do
  before :all do
    @adapter_path = File.dirname(__FILE__) / ".." / "lib" / "merb_mail_queue" / "adapters"
    @ar_path      = @adapter_path / "activerecord"
  end
  
  after :each do
    Merb::MailQueue::Adapters.class_eval do
      remove_const("ActiveRecord") if defined?(Merb::MailQueue::Adapters::ActiveRecord)
    end
  end
  
  def register_active_record!
    Merb::MailQueue.register_adapter :activerecord, "#{@adapter_path}/activerecord"
  end
  
  def stub_orm_scope(scope = :activerecord)
    Merb.stub!(:orm_generator_scope).and_return(scope)
  end  
  
  describe "#load_adapter!" do
    # TODO: figure out how to deal with class loading/reloading hell
    it "raises exception when adapter is not registred"
    
    it "loads the adapter"
  end
end