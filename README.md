# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| nick_name          | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_kana     | string  | null: false |
| first_name_kana    | string  | null: false |
| ad                 | integer | null: false |
| month              | integer | null: false |
| date               | integer | null: false |

### Association
- has_many :items
- belongs_to :orders


## items テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| item_name          | string  | null: false |
| item_text          | text    | null: false |
| item_price         | integer | null: false |
| prefecture_id      | references | null: false, foreign_key: true |
| category_id        | references | null: false, foreign_key: true |
| condition_id       | references | null: false, foreign_key: true |
| ship_cost_id       | references | null: false, foreign_key: true |
| deli_time_id       | references | null: false, foreign_key: true |
| user_id            | references | null: false, foreign_key: true |

### Association
- belongs_to :uesrs
- belongs_to :prefectures
- belongs_to :categorys
- belongs_to :conditions
- belongs_to :shippingcosts
- belongs_to :deliverytimes


## prefectures テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| prefecture         | text   | null: false |

### Association
- has_many :items
- has_many :orders


## conditions テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| conditon           | text   | null: false |

### Association
- has_many :items

## categorys テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| category           | text   | null: false |

### Association
- has_many :items


## shippingcosts テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| ship_cost          | text   | null: false |

### Association
- has_many :items

## deliverytimes テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| deli_time          | text   | null: false |

### Association
- has_many :items


## orders テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| card_num           | integer | null: false |
| name               | text    | null: false |
| deadline           | integer | null: false |
| security_code      | integer | null: false |
| postal_code        | integer | null: false |
| city               | string  | null: false |
| adress             | string  | null: false |
| building_name      | string  |             |
| prefecture_id      | references | null: false, foreign_key: true |

### Association
- belongs_to :prefectures

