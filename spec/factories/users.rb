FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { 'path/to/default/photo.jpg' }
    posts_counter { 0 }
  end
end
