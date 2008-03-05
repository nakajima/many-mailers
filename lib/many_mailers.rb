module Animoto
  module ManyMailers
    def self.included(base)
      base.extend(ClassMethods)      
      base.class_eval do
        @@mail_servers = { }        
        cattr_accessor :mail_servers
        load_settings!
      end
    end
    
    module ClassMethods
      def with_settings(name, &block)
        self.class_inheritable_accessor :smtp_settings
        self.smtp_settings = ActionMailer::Base.mail_servers[name]
        yield self
        self.smtp_settings = ActionMailer::Base.mail_servers[:default]
      end
           
      def load_settings!(file_path = "#{RAILS_ROOT}/config/mail_servers.yml")
        YAML.load_file(file_path).each do |key, value|
          mail_servers[key.to_sym] = value.to_options!
          self.smtp_settings = mail_servers[:default]
        end
        rescue
          puts "=> \"#{file_path}\" not found! Using default SMTP settings (if any)."
      end
    end
  end
end

ActionMailer::Base.send :include, Animoto::ManyMailers