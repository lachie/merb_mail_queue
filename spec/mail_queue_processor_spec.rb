require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) / '..' / "lib" / "merb_mail_queue"
require File.dirname(__FILE__) / "active_record_helper"
Merb::MailQueue.load_plugin!


describe Merb::MailQueue::Processor do
  before :each do
    @processor = Merb::MailQueue::Processor.new
  end
  
  it "loads the queue" do
    clear_mail_queue
    MailQueueJob.should_receive(:load_queue).and_return(create_mail_queue_jobs)
    
    @processor.process
  end
  
  it "processes each job in the queue" do
    clear_deliveries
    clear_mail_queue
    create_mail_queue_jobs
    
    @processor.process
    Merb::Mailer.deliveries.size.should == 2
  end
  
  it "sends emails using job attributes" do
    clear_deliveries
    clear_mail_queue
    jobs = create_mail_queue_jobs
    
    @processor.process
    
    email = Merb::Mailer.deliveries.first
    
    # HEADER.first is because of the way MailFactory stores headers
    email.to.first.should == jobs.first.to
    email.from.first.should == jobs.first.from
    
    email.body.first.should == jobs.first.body
  end  
  
  it "destroys processed jobs" do
    clear_deliveries
    clear_mail_queue
    create_mail_queue_jobs
    
    MailQueueJob.count.should_not == 0
    @processor.process
    MailQueueJob.count.should == 0    
  end
end