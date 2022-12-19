require 'yaml'
require_relative '../config/const'

class Database
  def initialize
    @database_path = ConfigConst::Path::Database
  end

  def _create_if_not_exist(dirname)
    require 'fileutils'
    FileUtils.mkdir_p dirname
  end

  def save(object_id,data)
    pod = object_id[..1]
    self._create_if_not_exist("#{@database_path}/#{pod}")
    File.open("#{@database_path}/#{pod}/#{object_id}.object", 'w') do |f|
      f << data.to_yaml
    end
  end

  def get(object_id)
    pod = object_id[..1]
    return YAML.load(File.open("#{@database_path}/#{pod}/#{object_id}.object"))
  end

  def all
    objects = Dir["#{@database_path}/**/*.object"]
    result = {}
    objects.map do |object_path|
      object_id = File.basename(object_path, ".object")
      result[object_id] = self.get(object_id)
    end
    return result
  end
end

DB = Database.new