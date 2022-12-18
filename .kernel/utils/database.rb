require 'yaml/dbm'
require_relative '../config/const'

DB = YAML::DBM.new(ConfigConst::Path::Database)