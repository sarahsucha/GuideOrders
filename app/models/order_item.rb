class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order
  has_many :customers, :through => :order
  has_many :users, :through => :order

  validates :quantity, presence: true
  validates :price_paid_per_book_orig, presence: true
  validates :book_id, presence: true
  validates :order_id, presence: true

  # validates :venice_or_prague

  private

  # def venice_or_prague
  #   if !(venice_quantity.present? || prague_quantity.present?)
  #     errors.add(:quantity, "Quantity for either Venice or Prague must be filled in")
  #   end
  # end
end
