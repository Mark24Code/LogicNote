require 'yaml'
require_relative '../config/const'
class Config
  def initialize
    @user_config_path = ConfigConst::Path::UserSetting
  end

  def userconfig(new_hash = nil)
    userconfig = YAML.load(File.open(@user_config_path))
    if !new_hash 
      return userconfig || {}
    else 
      new_userconfig = {}
      new_userconfig.merge!(userconfig, new_hash)
      config_yaml = new_userconfig.to_yaml
      File.open(@user_config_path, 'w') do |f|
        f << config_yaml
      end
    end
  end
end