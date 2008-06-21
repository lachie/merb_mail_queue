module Merb
  module MailQueue
    module MailQueueMixin
      
      def queue_mail(klass, method, mail_params, send_params = nil)
        klass.new(send_params || params, self).dispatch_and_queue(method, mail_params)
      end
      
    end
  end
end

module Merb
  module MailQueue
    module DispatchAndQueueMixin

      def dispatch_and_queue(method, mail_params)
        @mailer         = self.class._mailer_klass.new(mail_params)
        @mail           = @mailer.mail
        @method         = method

        # dispatch and render use params[:action], so set it
        self.action_name = method

        body             = _dispatch method
        if !@mail.html.blank? || !@mail.text.blank?
          body = @mail.html || @mail.text
          Merb::MailQueue.mail_queue_job_model_class.queue(@mail.from, @mail.to.first, @mail.subject.first, body)
          Merb.logger.info "Email queued: to #{@mail.to} about #{@mail.subject}"
        else
          Merb.logger.info "#{method} was not sent because nothing was rendered for it"
        end        
      end
          
    end
  end
end