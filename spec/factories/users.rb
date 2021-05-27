FactoryBot.define do
  factory :customer, class: "User" do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}
    role {User.roles[:customer]}
    activated {true}
    activated_at {Time.zone.now}
  end

  factory :admin, class: "User" do
    name {Faker::Name.name}
    email {"user_test@gmail.com"}
    password {"123456"}
    password_confirmation {"123456"}
    role {User.roles[:admin]}
    activated {true}
    activated_at {Time.zone.now}
  end
end
