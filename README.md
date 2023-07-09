# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | -----------               |
| nickname           | string | null: false, unique: true |
| email              | string | null: false  unique: true |
| encrypted_password | string | null: false  unique: true |
| surname            | string | null: false               |
| given_name         | string | null: false               |
| surname_kana       | string | null: false               |
| given_name_kana    | string | null: false               |
| birth_year         | date   | null: false               |
| birth_month        | date   | null: false               |
| birth_day          | date   | null: false               |

### Association
has_many :item
has_many :purchase

## items テーブル

| Column             | Type       | Options                       |
| ------------------ | ------     | -----------                   |
| image              | string     | null: false                   |
| name               | string     | null: false                   |
| description        | text       | null: false                   |
| category           | integer    | null: false                   |
| condition          | integer    | null: false                   |
| shipping_charges   | integer    | null: false                   |
| region_of_origin   | integer    | null: false                   |
| delivery_days      | integer    | null: false                   |
| price              | integer    | null: false                   |
| user_id            | references | null: false foreign_key: true |

### Association
belongs_to :user
has_many :purchase

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
| post_code          | string     | null: false                   |
| prefectures        | string     | null: false                   |
| municipalities     | string     | null: false                   |
| address            | string     | null: false                   |
| building_name      | string     |                               |
| phone_number       | string     | null: false                   |

### Association
belongs_to :purchase