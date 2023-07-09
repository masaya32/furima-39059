# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | -----------               |
| nickname           | string | null: false,              |
| email              | string | null: false  unique: true |
| encrypted_password | string | null: false               |
| surname            | string | null: false               |
| given_name         | string | null: false               |
| surname_kana       | string | null: false               |
| given_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association
has_many :items
has_many :purchases

## items テーブル

| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| user               | references | null: false foreign_key: true |
| name               | string     | null: false                   |
| description        | text       | null: false                   |
| category_id        | integer    | null: false                   |
| condition_id       | integer    | null: false                   |
| shipping_charge_id | integer    | null: false                   |
| prefecture_id      | integer    | null: false                   |
| shipping_date_id   | integer    | null: false                   |
| price              | integer    | null: false                   |

### Association
belongs_to :user
has_one :purchase

## purchases テーブル

| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| user               | references | null: false foreign_key: true |
| item               | references | null: false foreign_key: true |

### Association
belongs_to :user
belongs_to :item
has_one :shipping

## shippings テーブル

| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| purchase           | references | null: false foreign_key: true |
| post_code          | string     | null: false                   |
| prefecture_id      | string     | null: false                   |
| municipalities     | string     | null: false                   |
| address            | string     | null: false                   |
| building_name      | string     |                               |
| phone_number       | string     | null: false                   |

### Association
belongs_to :purchase