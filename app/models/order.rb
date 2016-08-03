class Order < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :book
  belongs_to :customer
end
