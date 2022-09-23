FactoryBot.define do
  factory :purchase_contact do
    post_code     { '332-1110' }
    region_id     { 12 }
    city          { '埼玉県' }
    house_number  { '1-2' }
    building      { 'Super House' }
    phone_number  { '08012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
