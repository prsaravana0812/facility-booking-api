# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

pp "------------------------------"
pp "Seeding data"
pp "------------------------------"

Room.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("rooms")

Room.find_or_create_by(room_id: "r1", name: "Room 1")
Room.find_or_create_by(room_id: "r2", name: "Room 2")
Room.find_or_create_by(room_id: "r3", name: "Room 3")
Room.find_or_create_by(room_id: "r4", name: "Room 4")
Room.find_or_create_by(room_id: "r5", name: "Room 5")

pp "Seeded successfully"
pp "------------------------------"