# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

irs = YAML.load(File.read(Rails.root.join("config/irs_docs.yaml")))
irs["documents"].each { |url| TaxEntity.load_990(url) }
