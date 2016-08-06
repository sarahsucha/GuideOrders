class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order
  has_many :customers, :through => :order
  has_many :users, :through => :order
end
