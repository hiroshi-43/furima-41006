FactoryBot.define do
  factory :item_address do
    postal_code { "#{Faker::Number.between(from: 100, to: 999)}-#{Faker::Number.between(from: 1000, to: 9999)}" }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building_name { '' } # ここは空のままにします
    phone_num { Faker::Number.leading_zero_number(digits: 11) }
    prefecture_id { Faker::Number.between(from: 0, to: 48) }
    user_id { Faker::Number.non_zero_digit }
    item_id { Faker::Number.non_zero_digit }
  end
end
