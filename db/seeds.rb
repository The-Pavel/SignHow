# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# GIF.delete_all

User.delete_all


# Seeding Users:
User.create(first_name: 'Jane', last_name: 'Wong', email: 'jwly1024@gmail.com', password: '123456', is_teacher: true)
User.create(first_name: 'Martin', last_name: 'Tannenberger', email: 'martin.tannenberger@gmail.com', password: '123456', is_teacher: false)

4.times do
User.create(first_name: Faker::Pokemon.name, last_name: Faker::Pokemon.move, email: Faker::Internet.email, password: '123456', is_teacher: [true, false].sample)
end

# puts "created #{User.count} users"
#
# # Seeding Meals:
#
# categories = %w(Sichuan Yunnan Xinjiang Hunan)
#
# 15.times do
#   Meal.create(name: Faker::Food.dish, category: categories.sample, description: Faker::Food.description, price: Faker::Number.between(1, 10), user_id: User.all.sample.id, picture: images.sample)
# end
#
# puts "created #{Meal.count} meals"
