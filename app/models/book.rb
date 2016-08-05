class Book < ActiveRecord::Base
  # Remember to create a migration!
  has_many :order_items
  has_many :orders, :through => :order_items
  has_many :customers, :through => :orders
  has_many :users, :through => :orders
end
