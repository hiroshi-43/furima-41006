FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    item_text { Faker::Lorem.paragraph }
    category_id { Faker::Number.between(from: 1, to: 11) } # カテゴリーIDは適宜変更
    condition_id { Faker::Number.between(from: 1, to: 7) } # 商品の状態IDは適宜変更
    ship_cost_id { Faker::Number.between(from: 1, to: 3) } # 配送料負担IDは適宜変更
    prefecture_id { Faker::Number.between(from: 1, to: 48) } # 都道府県IDは適宜変更
    deli_time_id { Faker::Number.between(from: 1, to: 4) } # 発送までの日数IDは適宜変更
    price { Faker::Number.between(from: 300, to: 9_999_999) } # 価格の範囲は適宜変更

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('bin/public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
