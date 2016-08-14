class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  has_many :order_items

  validates :sold_date, presence: true
  validates :user_id, presence: true
  validates :currency_type, presence: true

  def order_total
    order_total = 0
    order_items = self.order_items
    order_items.each do |order_item|
      order_total += order_item.price_paid_per_book_orig * order_item.quantity
    end
    order_total.to_f / 100
  end

  def convert_to_czk(rate)
    p self.order_total
    self.order_total / rate
  end

end
