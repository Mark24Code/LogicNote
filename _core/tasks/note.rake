require_relative '../utils/config'
require_relative '../utils/database'

namespace "note" do
  desc "note: create note."
  task :new ,[:notename]do |t, args|
    notename = args[:notename]
    userconfig = Config.new.userconfig
    puts "notename:",notename
    
    filename = nil
    if !notename.include?('/') 
      filename = notename
      notename = "#{userconfig[:default_notebook_name]}/#{notename}"
    else
      filename = notename.clone.split('/').last
    end
    require 'fileutils'
    dirname = File.dirname(notename)
    unless File.directory?(dirname)
      FileUtils.mkdir_p("#{userconfig[:notes_dir]}/#{dirname}")
    end

    date = Time.now.strftime("%Y-%m-%d")
    time = Time.now.strftime("%Y-%m-%d %H:%M:%S %z")
    note_time_name = "#{time} #{notename}"
    require 'digest'
    object_id = Digest::MD5.hexdigest(note_time_name)
    output_filename = "#{date}.#{filename}.#{object_id[..userconfig[:object_id_length]]}"
    temple = "---
id: #{object_id}
title: #{filename}
date: #{time}
book: #{dirname}
---
  "
    File.open("#{userconfig[:notes_dir]}/#{dirname}/#{output_filename}.md", 'w') do |f|
      f << temple
    end
    
    DB.save(object_id, {
      id: object_id,
      title: filename,
      date: time,
      book: dirname,
    })
    puts "[create note] #{output_filename}"
  end

  desc "note:list note."
  task :list do |t|
    require 'terminal-table'
    note_ids = []
    rows = []
    notes_meta_info = DB.all
    note_ids = notes_meta_info.keys
    note_ids.each do |note_id|
      note = notes_meta_info[note_id]
      rows << [note[:id][..8], note[:date],note[:book],note[:title]]
    end
    puts "total: #{note_ids.length}"
    table = Terminal::Table.new :headings => ['Id', 'Date','Book','Title'], :rows => rows
    puts table
    puts "total: #{note_ids.length}"
    # TODO
    # 分页展示，更改交互，到 less，突然明白 git 为什么要进入滚动模式了
    # 也许我们也应该进入滚动模式
  end

  desc "note:search note."
  task :search do
    puts "search"
    # TODO
    # 收集在索引标题中的模糊查找
    # 全文搜索摘要前10
  end

  desc "note:delete note."
  task :delete do
    puts "delete"
    # TODO
    # 移动到 Trash,更新信息，一切统计绕过 Trash，Trash可以还原
    # Purge 是清除 一个笔记
  end

  desc "note:purge note."
  task :purge do
    puts "[note purge] delete all"
    puts "Are you sure delete all notes? (Yes/No)"
    result = STDIN.gets
    result = result.strip
    if result == 'Yes'
      userconfig = Config.new.userconfig
      system("rm -rf #{userconfig[:notes_dir]}")
      system("mkdir #{userconfig[:notes_dir]}")
      system("touch #{userconfig[:notes_dir]}/.keep")
      system("rm -rf #{ConfigConst::Path::Database}")
      system("mkdir #{ConfigConst::Path::Database}")
      system("touch #{ConfigConst::Path::Database}/.keep")
    else
      puts "[note purge] cancel."
    end

  end
end