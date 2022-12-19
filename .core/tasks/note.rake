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
      FileUtils.mkdir_p("./_notes/#{dirname}")
    end

    date = Time.now.strftime("%Y-%m-%d")
    time = Time.now.strftime("%Y-%m-%d %H:%M:%S %z")
    note_time_name = "#{time} #{notename}"
    require 'digest'
    hash_id = Digest::MD5.hexdigest(note_time_name)
    output_filename = "#{date}.#{filename}.#{hash_id[..userconfig[:hash_id_length]]}"
    temple = "---
id: #{hash_id}
title: #{filename}
date: #{time}
book: #{dirname}
categories: 未定义
layout: post
location: null
author: #{userconfig[:username]}
email: #{userconfig[:email]}
---
  "
    File.open("./_notes/#{dirname}/#{output_filename}.md", 'w') do |f|
      f << temple
    end
    
    DB[hash_id] = {
      id: hash_id,
      title: filename,
      date: time,
      book: dirname,
      categories: "未定义",
      layout: "post",
      location: nil,
      author: userconfig[:username],
      email: userconfig[:email],
    }

    puts "[create note] #{output_filename}"
  end

  desc "note:list note."
  task :list do |t|
    require 'terminal-table'
    note_ids = DB.keys
    rows = []
    note_ids.each do |note_id|
      note = DB[note_id]
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
end