#!/usr/bin/env ruby
require 'fileutils'

posts_dir = "_posts"

Dir.glob("#{posts_dir}/*.md") do |file|
  filename = File.basename(file)

  # Cherche un nom de fichier avec deux dates au début
  if filename =~ /^\d{4}-\d{2}-\d{2}-(\d{4}-\d{2}-\d{2}-.+)$/ 
    new_name = $1
    old_path = file
    new_path = File.join(posts_dir, new_name)
    
    FileUtils.mv(old_path, new_path)
    puts "✅ Renommé : #{filename} → #{new_name}"
  else
    puts "⏩ Ignoré : #{filename}"
  end
end

puts "\n🎉 Terminé !"
