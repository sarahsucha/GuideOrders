class Book < ActiveRecord::Base
  has_many :order_items

  validates :title, presence: true
  validates :printing_cost_czk, presence: true
end
