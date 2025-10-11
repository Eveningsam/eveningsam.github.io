require 'jekyll-import'

JekyllImport::Importers::WordpressDotCom.run({
  "source" => "/Users/Sami/Downloads/sonnequipeut.WordPress.2025-10-09.xml",
  "no_fetch_images" => false,
  "assets_folder" => "assets/images"
})

puts "Import terminé !"
