FactoryBot.define do
  factory :order do
    note {"note"}
    user_id {1}
    after :build do |order|
      byebug
      order.order_details << build(:order_detail, order: order)
      order.delivery_address = create(:delivery_address, user: order.user)
    end
  end
end
