class Sale < ApplicationRecord
  belongs_to :product

  scope :within_date, ->(date){where date: date}
  scope :total_revenue, ->(date){where(date: date).sum :revenue}

  delegate :name, to: :product, prefix: true

  class << self
    def statisticize_sale date
      delete_former_query = "delete from sales
                             where date = '#{date.strftime '%Y-%m-%d'}';"
      created_time = Time.zone.today.strftime "%Y-%m-%d"
      insert_query = "
        insert into sales(product_id, quantity, revenue, date, created_at,
                                                               updated_at)
        select product_id, sum(quantity), sum(quantity*price),
               '#{date.strftime '%Y-%m-%d'}' ,'#{created_time}',
               '#{created_time}'
        from (#{OrderDetail.created_date(date).to_sql}) as t
        group by product_id;
      "
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute(delete_former_query)
        ActiveRecord::Base.connection.execute(insert_query)
      end
    end
  end
end
