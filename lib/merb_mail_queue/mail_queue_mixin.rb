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
          
          Merb::MailQueue.mail_queue_job_model_class.queue(
            mail_params[:from], mail_params[:to], mail_params[:subject], @mail.text, @mail.html
          )
          
          Merb.logger.info "Email queued: \n\tfrom #{mail_params[:from]} \n\tto #{mail_params[:to]} \n\tabout #{mail_params[:subject]}."
        else
          Merb.logger.info "#{method} was not sent because nothing was rendered for it"
        end        
      end
          
    end
  end
end