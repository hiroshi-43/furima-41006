FactoryBot.define do
  factory :item_address do
    postal_code { "#{Faker::Number.between(from: 100, to: 999)}-#{Faker::Number.between(from: 1000, to: 9999)}" }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building_name { '' } # ここは空のままにします
    phone_num { Faker::Number.leading_zero_number(digits: 11) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    token { "tok_#{SecureRandom.alphanumeric(24)}" } # ランダムなトークンを生成
  end
end
