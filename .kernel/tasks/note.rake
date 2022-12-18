require_relative '../utils/config'

namespace "note" do
  desc "note: create note."
  task :new ,[:note_name]do |t, args|
    note_name = args[:note_name]
    userconfig = Config.new.userconfig
    puts "note_name:",note_name
    puts userconfig
    
    # dirname,filename = filepath.split('/')
    # puts dirname
    # puts filename

    note_name = args[:note_name]
    date = Time.now.strftime("%Y-%m-%d")
    time = Time.now.strftime("%Y-%m-%d %H:%M:%S %z")
    file_name = "#{time}-#{note_name}"
  
    temple = "---
title: #{note_name}
date: #{time}
categories: 未定义
layout: post
location: null
author: #{userconfig[:username]}
email: #{userconfig[:email]}
---
  "
    File.open("./_notes/#{file_name}.md", 'w') do |f|
      f << temple
    end
  
    puts "[create note] #{file_name}"
  end

  desc "note:search note."
  task :search do
    puts "search"
    # Build the main program
  end

  desc "note:delete note."
  task :delete do
    puts "delete"
    # Build the main program
  end
end