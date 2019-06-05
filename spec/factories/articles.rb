FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    body { Faker::Lorem.paragraphs(6) }
    description { Faker::Lorem.sentence }
    favorites_count { Faker::Number.number(1) }
    slug { Faker::Lorem.word }
    user_id { create(:user) }
  end
end