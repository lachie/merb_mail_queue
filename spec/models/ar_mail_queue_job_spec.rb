require File.join( File.dirname(__FILE__), "..", "spec_helper" )
require File.dirname(__FILE__) / ".." / '..' / "lib" / "merb_mail_queue"

require File.dirname(__FILE__) / ".." / "active_record_helper"


describe "ActiveRecord MailQueueJob model" do
  describe "#load_queue" do
    it "loads queued jobs" do
      clear_mail_queue
      create_mail_queue_jobs
      
      queue = MailQueueJob.load_queue
      queue.size.should == 2
      queue.first.subject.should == "Merb Mail queue plugin"      
    end
  end
end