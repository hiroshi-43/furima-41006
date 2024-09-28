FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    last_name             { (1..2).map { Faker::Japanese.kanji }.join }
    first_name            { (1..2).map { Faker::Japanese.kanji }.join }
    last_name_kana        { (1..2).map { Faker::Japanese.katakana }.join }
    first_name_kana       { (1..2).map { Faker::Japanese.katakana }.join }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false) + rand(10).to_s }
    password_confirmation { password }
    birthday              { Faker::Date.between(from: '1930-01-01', to: '2019-12-31') }
  end
end
