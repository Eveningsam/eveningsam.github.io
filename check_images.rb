#!/usr/bin/env ruby
require 'yaml'
require 'date'    # <- ajouté
require 'fileutils'

POSTS_DIR = "_posts"
ASSETS_DIR = "assets/images"

puts "🔹 Vérification des images référencées dans les posts..."

Dir.glob("#{POSTS_DIR}/*.{md,markdown}").each do |file|
  text = File.read(file)

  # Extraire le front matter YAML
  if text =~ /\A---\s*\n(.*?)\n---/m
    data = YAML.safe_load($1, permitted_classes:[Date], aliases:true) || {}
    
    if data['image']
      image_path = data['image']
      # Retirer un éventuel / au début pour construire le chemin physique
      physical_path = image_path.start_with?("/") ? image_path[1..-1] : image_path

      if File.exist?(physical_path)
        puts "✅ OK: #{file} -> #{image_path}"
      else
        puts "❌ Manquant: #{file} -> #{image_path}"
      end
    end
  else
    puts "⚠️ Pas de front matter détecté dans #{file}"
  end
end

puts "🔹 Vérification terminée !"
