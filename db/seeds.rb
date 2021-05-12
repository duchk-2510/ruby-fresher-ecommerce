User.create!(
  name: "Sample User",
  email: "hoangkimduclqd@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1,
  activated: true,
  activated_at: Time.zone.now,
)

30.times do |n|
  name = Faker::Name.name
  email = "user-email#{n + 1}@rails.com"
  password = "123456"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
  )
end
