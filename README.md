# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# テーブル設計

<!-- ******************************************************* -->

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday_year      | string | null: false |
| birthday_month     | string | null: false |
| birthday_day       | string | null: false |

### Association

- has_many :items
- has_many :purchases

<!-- ******************************************************* -->

## items テーブル

| Column       | Type       | Options                         |
| ------------ | ---------- | ------------------------------- |
| name         | string     | null: false                     |
| introduction | text       | null: false                     |
| category     |            | null: false                     |
| status       |            | null: false                     |
| charge_type  |            | null: false                     |
| region       |            | null: false                     |
| delivery_time|            | null: false                     |
| price        |            | null: false                     |
| user         | references | null: false, foreign_keys: true |

### Association

- belongs_to :user
- has_one :purchase

<!-- ******************************************************* -->

## purchases テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_many: contacts

<!-- ******************************************************* -->

## contacts テーブル

| Column         | Type       | Options                        |
| ---------      | ---------- | ------------------------------ |
| post_code      | string     | null: false                    |
| province       |            | null: false                    |
| city           | string     | null: false                    |
| house_number   | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| purchase_id    | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase

<!-- ******************************************************* -->