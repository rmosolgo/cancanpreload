# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

trees = {
  "one" => ["two", "three", "four"],
  "un" => ["deux", "trois", "quatre"],
  "一" => ["二", "三", "四"],
}

Thing.delete_all

trees.each do |parent_name, children|
  parent = Thing.create!(name: parent_name)
  children.each { |c| Thing.create!(name: c, parent: parent) }
end
