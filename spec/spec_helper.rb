require 'rubygems'
require 'merb-core'
require 'spec'
require 'merb-mailer'
require 'activerecord'

class Merb::Mailer
  self.delivery_method = :test_send
end

module Merb
  def self.orm_generator_scope
    :activerecord
  end
end

class MailQueueJob < ActiveRecord::Base
end

def clear_deliveries
  Merb::Mailer.deliveries.clear
end

# Using Merb.root below makes sure that the correct root is set for
# - testing standalone, without being installed as a gem and no host application
# - testing from within the host application; its root will be used
Merb.start_environment(
  :testing       => true, 
  :adapter       => 'runner', 
  :environment   => ENV['MERB_ENV'] || 'test',
  :merb_root     => Merb.root,
  :session_store => 'memory'
)