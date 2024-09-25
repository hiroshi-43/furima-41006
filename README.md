# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| nickname           | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_kana     | string  | null: false |
| first_name_kana    | string  | null: false |
| birthday           | date    | null: false |

### Association
- has_many :items
- has_many :orders


## items テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| item_name          | string  | null: false |
| item_text          | text    | null: false |
| price              | integer | null: false |
| prefecture_id      | integer | null: false |
| category_id        | integer | null: false |
| condition_id       | integer | null: false |
| ship_cost_id       | integer | null: false |
| deli_time_id       | integer | null: false |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :uesr
- has_one :order

## residences テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| postal_code        | string  | null: false |
| city               | string  | null: false |
| adress             | string  | null: false |
| building_name      | string  |             |
| prefecture_id      | integer | null: false |
| phone_num          | string  | null: false |
| order              | references | null: false, foreign_key: true |

### Association
- belongs_to :order

## orders テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :order
- has_one :residence

