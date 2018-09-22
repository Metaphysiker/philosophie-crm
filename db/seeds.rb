# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
    username: "Sandro",
    email: "sandro.raess@philosophie.ch",
    password: 123456
)

User.create(
    username: "Anja",
    email: "anja.leser@philosophie.ch",
    password: 123456
)

TagList.create(
  name: "Sponsor"
)

TagList.create(
  name: "Medienkontakt"
)

TagList.create(
  name: "Kooperationspartner"
)
