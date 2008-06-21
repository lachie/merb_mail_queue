Merb::Plugins.config[:merb_mail_queue] = {
  :mail_queue_job_model_class_name => "MailQueueJob",
  :adapter                         => :activerecord
}

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection(:adapter  => 'sqlite3', :database => ':memory:')
 
class MailQueueJobMigration < ActiveRecord::Migration
  def self.up
    create_table "mail_queue_jobs", :force => true do |t|
      t.string :to,         :string
      t.string :from,       :string
      t.string :subject,    :string
      t.text   :text
      t.text   :html
      
      t.timestamps
    end
  end
end
MailQueueJobMigration.up

def clear_mail_queue
  MailQueueJob.delete_all
end

def create_mail_queue_jobs
  first = MailQueueJob.create!(
    :to      => "mail@queue.plugins.merbivore.com",
    :from    => "activerecord@queue.plugins.merbivore.com",
    :subject => "Merb Mail queue plugin",
    :text    => "This plugin makes email queueing simpler than before!"
  )
  
  second = MailQueueJob.create!(
    :to      => "mail@queue.plugins.merbivore.com",
    :from    => "activerecord@queue.plugins.merbivore.com",
    :subject => "Merb Mail queue plugin, take 2",
    :html    => "This plugin for <a href='http://merbivore.com'>Merb</a> work with ActiveRecord"
  )
  
  [first, second]
end