namespace :mailers do
  desc "Show mailer servers"
  task :show do
    path = RAILS_ROOT + '/config/mail_servers.yml'
    if File.file?(path)
      puts "** displaying mailer settings"
      puts File.read(path)
    else
      puts "** Can't find mail_servers.yml!"
    end
  end
end