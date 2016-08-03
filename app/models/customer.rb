class Customer < ActiveRecord::Base
  # Remember to create a migration!
  has_many :orders
  has_many :books, :through => :orders
end
