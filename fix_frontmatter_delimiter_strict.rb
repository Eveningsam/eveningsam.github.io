#!/usr/bin/env ruby
POSTS_DIR = "_posts"

puts "🔹 Correction du front matter collé..."

Dir.glob("#{POSTS_DIR}/*.{md,markdown}") do |file|
  raw = File.read(file)

  # Détecter le front matter YAML même si le --- de fin est collé
  if raw.start_with?('---')
    # Chercher le --- de fin
    idx = raw.index("\n---", 3) || raw.index("---", 3) # 3 = après premier ---
    if idx
      yaml_text = raw[3...idx].rstrip
      body = raw[(idx + 3)..-1].lstrip

      new_content = "---\n#{yaml_text}\n---\n\n#{body}"

      if new_content != raw
        File.write(file, new_content)
        puts "✅ #{File.basename(file)} corrigé"
      end
    else
      puts "⚠️ Pas de --- de fin détecté dans #{File.basename(file)}"
    end
  else
    puts "⚠️ Pas de front matter YAML détecté dans #{File.basename(file)}"
  end
end

puts "🔹 Terminé !"
