FactoryGirl.define do
  factory :recipe do
    user
    
    title { Faker::Hipster.sentence }
    
    story { Faker::Lorem.sentence }
    
    ingredients do
      number = rand(4..10)
      collection = Faker::Lorem.words(number).map do |sentence|
        number = rand(1..10)

        "- #{number} #{sentence}"
      end
      
      collection.join("\n")
    end
    
    instructions do
      number = rand(4..12)
      collection = []
      Faker::Lorem.sentences(number).each_with_index do |sentence, index|
         collection << "#{index}. #{sentence}\n"
      end
      
      collection.join("\n")
    end
  end
  
  factory :recipe_without_story, parent: :recipe do
    story nil
  end
end
