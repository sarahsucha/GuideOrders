class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order
  has_many :customers, :through => :order
  has_many :users, :through => :order

  validates :quantity, presence: true
  validates :price_paid_per_book_orig, presence: true
  validates :book_id, presence: true
  validates :order_id, presence: true

  def display_item_amount
    amount = self.price_paid_per_book_orig.to_f
    '%.2f' % (amount / 100)
  end

end
