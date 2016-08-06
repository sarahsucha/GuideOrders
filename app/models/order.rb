class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  has_many :order_items
end
