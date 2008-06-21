require File.dirname(__FILE__) + '/spec_helper'

Spec::Runner.configure do |config|
  config.include Merb::Test::RequestHelper  
end

require File.dirname(__FILE__) / '..' / "lib" / "merb_mail_queue"
require File.dirname(__FILE__) / "active_record_helper"
Merb::MailQueue.load_plugin!

Merb.push_path(:mailer, File.join(File.dirname(__FILE__), "mailers"))

describe Merb::MailQueue::MailQueueMixin do
  it "is included into Merb::Controller" do
    Merb::Controller.should < Merb::MailQueue::MailQueueMixin
  end  
end


class DelayedMailController < Merb::MailController
  def first
    render_mail :text => :first
  end
  
  def second
    render_mail
  end
end  


class QueueingController < Merb::Controller
  def does_queueing_of_first_email
    queue_mail DelayedMailController, :first, :from => "joe_the_programmer@some.where", :to => "no-reply@merb-plugins.org"
  end
  
  def does_queueing_of_second_email
    queue_mail DelayedMailController, :second, :from => "joe_the_programmer@some.where", :to => "no-reply@merb-plugins.org"
  end  
end


describe "A Merb Mail controller" do
  
  def queue(action)
    DelayedMailController.new({}).dispatch_and_queue action, :from => "joe_the_programmer@some.where", :to => "no-reply@merb-plugins.org"
    @delivery = Merb::Mailer.deliveries.last
  end

  undef :call_action if defined?(call_action)
  def call_action(action)
    dispatch_to(QueueingController, action)
    @delivery = Merb::Mailer.deliveries.last  
  end
  
  it "should render files in its directory by default" do
    queue :first
    MailQueueJob.last.text.should == "First message."
  end
  
  it "should render files in its directory without a mimetype extension by default" do
    call_action :does_queueing_of_second_email
    MailQueueJob.last.html.should == "Second message."
  end
end