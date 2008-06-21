require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) / '..' / "lib" / "merb_mail_queue"
Merb::MailQueue.load_plugin!

describe Merb::MailQueue do
  before :all do
    @adapter_path = File.dirname(__FILE__) / ".." / "lib" / "merb_mail_queue" / "adapters"
    @ar_path      = @adapter_path / "activerecord"
  end  
  
  def register_active_record!
    Merb::MailQueue.register_adapter :activerecord, "#{@adapter_path}/activerecord"
  end
  
  def clear_adapter_list!
    Merb::MailQueue.clear_adapter_list!
  end
  
  def stub_orm_scope(scope = :activerecord)
    Merb.stub!(:orm_generator_scope).and_return(scope)
  end

  
  describe "#adapters" do
    # this example depends on exampels run order
    # but it simplifies plugin loading/reloading hell in specs in general 
    it "return a hash of registered adapters" do    
      Merb::MailQueue.adapters.should be_a_kind_of(Hash)
    end    
  end

  
  describe "#register_adapter" do
    it "registers ActiveRecord adapter on initialization" do
      Merb::MailQueue.adapters.should be_a_kind_of(Hash)
      
      Merb::MailQueue.adapters.keys.should include(:activerecord)
    end
    
    it "registers DataMapper adapter on initialization"
    
    it "registers Sequel adapter on initialization"
    
    it "adds adapter / path to adapters list" do
      clear_adapter_list!
      register_active_record!
      
      Merb::MailQueue.adapters[:activerecord][:path].should == @ar_path
    end
  end
  
  describe "#clear_adapter_list!" do
    it "clears adapter list in plugin configuration" do
      Merb::MailQueue.adapters.should_not be_empty
      Merb::MailQueue.clear_adapter_list!

      Merb::MailQueue.adapters.should be_empty
    end    
  end  
end