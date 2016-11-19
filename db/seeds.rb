# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || ENV['SEED_WITH_FAKE_RECIPES'].present?
  admin = User.admin.find_or_create_by(email: "admin@example.com", name: "Admin Example") do |user|
    password = "123456"

    user.password = password
    user.password_confirmation = password
  end

  if Recipe.count < 100
    total_with_story = rand(20..40)
    total_without_story = 100 - total_with_story
    
    users = [admin]
    4.times { users << FactoryGirl.create(:user) }
    
    total_with_story.times do
      FactoryGirl.create(:recipe, user: users.sample)
    end
    
    total_without_story.times do
      FactoryGirl.create(:recipe_without_story, user: users.sample)
    end
  end
end
