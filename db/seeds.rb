User.create!(
  name: "Sample User",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: User.roles[:admin],
  activated: true,
  activated_at: Time.zone.now
).confirm

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
    activated_at: Time.zone.now
  ).confirm
end

category_data = [
  ["Điện thoại - Máy tính bảng", nil], ["Điện máy",nil],
  ["Điện thoại thông minh", 1], ["Điện thoại phổ thông", 1], ["Máy tính bảng",1],
  ["Tivi", 2], ["Tủ lạnh", 2], ["Máy giặt", 2], ["Máy lạnh", 2],
  ["Điện thoại cao cấp", 3], ["Điện thoại tầm trung", 3], ["Điện thoại giá rẻ", 3],
  ["Tivi OLED", 6], ["Tivi MICROLED", 6], ["Tivi LED", 6],
  ["Tủ lạnh 50L", 7], ["Tủ lạnh 80L", 7], ["Tủ lạnh 135L", 7], ["Tủ lạnh 165L trở lên", 7],
  ["Tủ lạnh 2 cửa", 19], ["Tủ lạnh 3 cửa", 19]
]

category_data.each do |category|
  Category.create!(
    title: category[0],
    father_id: category[1]
  )
end

categories = Category.all

@no_of_product = 100
@no_of_product.times do |n|
  category = categories[Faker::Number.within(range: 0..20)]
  Product.create!(
    name: "Product #{n} - #{category.title}",
    manufacturer: Faker::Device.manufacturer,
    detail: "Product #{n + 1} detail",
    quantity: Faker::Number.within(range: 5..20),
    price: Faker::Number.within(range: 10..30) * 1000000,
    category_id: category.id
  )
end

30.times do |n|
  DeliveryAddress.create!(
    name: Faker::Name.unique.name,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    user_id: User.all.ids.sample
  )
end

5.times do |n|
  DeliveryAddress.create!(
    name: Faker::Name.unique.name,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    user_id: 1
  )
end

def fake_order_for_user user
  order = Order.new(
    status: Faker::Number.within(range: 0..4),
    created_at: Faker::Time.between(from: DateTime.now - 30, to: DateTime.now),
    delivery_address_id: user.delivery_addresses.sample.id,
    user_id: user.id
  )
  total = 0
  Faker::Number.within(range: 1..6).times do |n|
    detail = order.order_details.build(
      product_id: Faker::Number.within(range: 1..@no_of_product),
      quantity: Faker::Number.within(range: 1..3),
      price: Faker::Number.within(range: 10..30) * 1000000
    )
    total += detail.quantity * detail.price
  end
  order.shipping = Settings.order.shipping_cost_default
  total += order.shipping
  order.total = total
  order.note = "note"
  order.save
end

7.times do |n|
  fake_order_for_user(User.find_by id: 1)
end

40.times do |n|
  user = User.all.sample
  next unless user.delivery_addresses.count > 0

  fake_order_for_user user
end

(0..30).step(1) do |n|
  date = Date.today - n
  Sale.statisticize_sale date
end
