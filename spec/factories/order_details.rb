FactoryBot.define do
  factory :order_detail do
    quantity {Faker::Number.within range: 1..3}
    price {Faker::Number.within(range: 10..30) * 1000000}
    product
    order
  end
end
