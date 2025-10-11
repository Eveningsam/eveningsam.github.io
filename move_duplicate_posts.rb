#!/usr/bin/env ruby
require 'yaml'
require 'date'
require 'fileutils'

POSTS_DIR = "_posts"
DUP_DIR = "_posts/duplicates"

FileUtils.mkdir_p(DUP_DIR)

puts "🔹 Détection et déplacement des doublons dans #{POSTS_DIR}..."

posts_map = {}

Dir.glob("#{POSTS_DIR}/*.{md,markdown}").each do |file|
  text = File.read(file)
  
  if text =~ /\A---\s*\n(.*?)\n---/m
    data = YAML.safe_load($1, permitted_classes:[Date], aliases:true) || {}

    if data['title'] && data['date']
      key = "#{data['title'].strip}__#{data['date']}"
      
      if posts_map[key]
        puts "⚠️ Doublon détecté : #{file} -> déplacé dans #{DUP_DIR}"
        FileUtils.mv(file, DUP_DIR)
      else
        posts_map[key] = file
      end
    end
  else
    puts "⚠️ Pas de front matter détecté dans #{file}"
  end
end

puts "🔹 Déplacement terminé ! Les doublons sont dans #{DUP_DIR}."
