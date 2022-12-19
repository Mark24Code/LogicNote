require_relative '../utils/config'
require_relative '../utils/database'

namespace "index" do
  desc "index: rebuild notes index"
  task :rebuild do |t|
    # userconfig = Config.new.userconfig

    # notes_indexs = {}
    # # Dir["#{userconfig[:notes_dir]}/**/*.md"] do |md_file|

    # # end
    data = DB.all

    puts data
  end
end