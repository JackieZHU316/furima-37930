FactoryBot.define do
  factory :item do
    name              { 'test_for_item' }
    introduction      { 'This is introduction for item' }
    category_id       { 3 }
    status_id         { 3 }
    charge_type_id    { 3 }
    region_id         { 4 }
    delivery_time_id  { 3 }
    price             { 1000 }

  end
end
