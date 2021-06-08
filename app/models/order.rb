class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :delivery_address
  belongs_to :user

  enum status: {pending: 0, approved: 1, shipping: 2, finish: 3,
                canceled: 4, rejected: 6}

  validates :total, allow_nil: true,
                    numericality: {only_integer: true, greater_than: 0}

  scope :newest_first, ->{order created_at: :desc}
  scope :status, ->(status){where status: status}
  scope :created_date, ->(date){where "DATE(created_at) = ?", date}

  delegate :name, :phone, :address, to: :delivery_address, prefix: true
  delegate :email, to: :user, prefix: true
end
