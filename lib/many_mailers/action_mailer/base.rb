module Animoto
  module ManyMailers
    def self.included(base)
      base.extend(ClassMethods)      
      base.class_eval do
        @@mail_servers   = { }
        @@default_server = :default
        cattr_accessor :mail_servers
        cattr_reader :default_server
        load_settings!
      end
    end
    
    module ClassMethods
      def with_settings(name, &block)
        init_settings = self.smtp_settings
        use_server(name)
        yield self
        self.smtp_settings = init_settings
      end
      
      def use_server(name)
        @@default_server = name
        self.smtp_settings = mail_servers[@@default_server]
      end
      alias_method :default_server=, :use_server
           
      def load_settings!(file_path = "#{RAILS_ROOT}/config/mail_servers.yml")
        begin
          YAML.load_file(file_path).each { |key, value| mail_servers[key.to_sym] = value.to_options! }
          self.smtp_settings = mail_servers[default_server]
        rescue
          logger.warn "=> \"#{file_path}\" not found! Using default SMTP settings (if any)."
        end
      end
    end
  end
end

ActionMailer::Base.send :include, Animoto::ManyMailers