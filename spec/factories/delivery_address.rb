FactoryBot.define do
  factory :delivery_address do
    name {Faker::Name.unique.name}
    phone {Faker::PhoneNumber.phone_number}
    address {Faker::Address.full_address}
    user {association[:customer]}
  end
end
