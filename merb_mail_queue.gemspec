Gem::Specification.new do |s|
  s.name = %q{merb_mail_queue}
  s.version = "0.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Klishin"]
  s.date = %q{2008-06-21}
  s.description = %q{Merb plugin that provides mail queueing: asynchronous mail sending. Based on merb-mailer.}
  s.email = %q{michael@novemberain.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb_mail_queue", "lib/merb_mail_queue/adapters", "lib/merb_mail_queue/adapters/activerecord", "lib/merb_mail_queue/adapters/activerecord/init.rb", "lib/merb_mail_queue/adapters/activerecord/map.rb", "lib/merb_mail_queue/initializer.rb", "lib/merb_mail_queue/mail_queue_mixin.rb", "lib/merb_mail_queue/merbtasks.rb", "lib/merb_mail_queue/processor.rb", "lib/merb_mail_queue.rb", "spec/active_record_helper.rb", "spec/default_plugin_configuration_spec.rb", "spec/mail_queue_mixin_spec.rb", "spec/mail_queue_processor_spec.rb", "spec/mailers", "spec/mailers/views", "spec/mailers/views/delayed_mail_controller", "spec/mailers/views/delayed_mail_controller/first.html.erb", "spec/mailers/views/delayed_mail_controller/second.html.erb", "spec/merb_mail_queue_spec.rb", "spec/models", "spec/models/ar_mail_queue_job_spec.rb", "spec/orm_adapter_registration_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merbivore.com/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{Merb plugin that provides mail queueing: asynchronous mail sending. Based on merb-mailer.}

  s.add_dependency(%q<merb-core>, [">= 0.9.4"])
  s.add_dependency(%q<merb-mailer>, [">= 0.9.4"])
end
