FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { 'aaa111' }
    password_confirmation { password }
    last_name             { '山下' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマシタ' }
    first_name_kana       { 'タロウ' }
    birthday_date         { '1930-01-01 00:00:00' }
  end
end
