
class User < ActiveRecord::Base
  has_many :orders
  has_many :order_items, :through => :orders

  validates :email, presence: true
  validates :password, presence: true

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
