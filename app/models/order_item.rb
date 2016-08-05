class OrderItem < ActiveRecord::Base
  belongs_to :books
  has_many :customers, :through => :orders
  has_many :users, :through => :orders
end
