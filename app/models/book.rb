class Book < ActiveRecord::Base
  # Remember to create a migration!
  has_many :orders
  has_many :customers, :through => :orders
end
