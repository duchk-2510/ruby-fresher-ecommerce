class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :price, numericality: {only_integer: true, greater_than: 0}
  validates :quantity, numericality: {only_integer: true, greater_than: 0}

  delegate :name, to: :product, prefix: true

  scope :created_date, ->(date){where order_id: Order.created_date(date).ids}
end
