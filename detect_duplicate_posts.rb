#!/usr/bin/env ruby
require 'yaml'
require 'date'

POSTS_DIR = "_posts"

puts "🔹 Vérification des doublons dans #{POSTS_DIR}..."

# Hash pour stocker title+date => fichier
posts_map = {}

Dir.glob("#{POSTS_DIR}/*.{md,markdown}").each do |file|
  text = File.read(file)
  
  if text =~ /\A---\s*\n(.*?)\n---/m
    data = YAML.safe_load($1, permitted_classes:[Date], aliases:true) || {}
    
    if data['title'] && data['date']
      key = "#{data['title'].strip}__#{data['date']}"
      if posts_map[key]
        puts "⚠️ Doublon détecté :"
        puts "   #{posts_map[key]}"
        puts "   #{file}"
      else
        posts_map[key] = file
      end
    end
  else
    puts "⚠️ Pas de front matter détecté dans #{file}"
  end
end

puts "🔹 Vérification terminée !"
