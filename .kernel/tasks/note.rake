require_relative '../utils/config'

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
  
    puts "[create note] #{output_filename}"
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