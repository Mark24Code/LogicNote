require_relative '../utils/config'

namespace "config" do
  desc "name: get/set username"
  task :username ,[:username]do |t, args|
    username = args[:username]
    config = Config.new
    if !username
      userconfig = config.userconfig
      if !userconfig[:username]
        puts "[error: -1] username is nil"
        puts "try `rake \"config:username[your_username]\"` to set username"
      else 
        puts "username: #{userconfig[:username]}"
      end
      
    else 
      config.userconfig({username: username})
    end
  end

  desc "email: get/set email"
  task :email ,[:email]do |t, args|
    email = args[:email]
    config = Config.new
    if !email
      userconfig = config.userconfig
      email = userconfig[:email]
      if !userconfig[:username]
        puts "[error: -1] email is nil"
        puts "try `rake \"config:email[your_email]\"` to set email"
      else 
        puts "email: #{userconfig[:email]}"
      end
    else
      config.userconfig({email: email})
    end
  end
end