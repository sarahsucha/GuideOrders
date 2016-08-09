
class User < ActiveRecord::Base
  has_many :orders, { :foreign_key => :sold_by_id }
  has_many :order_items, :through => :orders

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(input_password)
    self.password == input_password
  end
end
