class Book < ActiveRecord::Base
  has_many :order_items
end
