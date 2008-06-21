module Merb
  module MailQueue
    class Processor

      def process(queue = Merb::MailQueue.mail_queue_job_model_class.load_queue)
        queue.each do |job|
          process_job(job)
        end
      end
      
      def process_job(job)
        Merb::Mailer.new(job.attributes).deliver!
          
        job.destroy
      end
    end
  end
end