# Orders INDEX (list of all orders, regardless of user)

# Orders CREATE
get '/users/:user_id/orders/new' do
  @errors = []
  erb :'orders/new'
end

# Orders READ
post '/users/:id/orders' do
  @errors = []
  #TODO how to update a customer - so we find their email... but let's say that now I know their last name, and fill it in (in the existing customer record, no last name is present). ALSO consider, as a user, maybe I want to be lazy and just enter the email address and not fill in the other information... in that case, I should select something if I want to update and then it will update the customer, otherwise it will just find by email and not update.
  # Also consider that I may have a repeating customer and not have their email address... or how do I update their email address (will need to be a future implementation of customer management and updating.)

  # if quantity does not exist for either venice or prague
  # p "*" * 80

  @errors = check_for_errors(params)

  if @errors.length > 0
    # p "I'm in the if that errors length is > 0"
    return erb :"orders/new"
  end

  customer = Customer.find_by(email: params["customer_email"])

  if customer == nil
    p "I'm in the if that customer does not exist"
    customer = Customer.create(first_name: params["customer_first_name"], last_name: params["customer_last_name"], company: params["customer_company"], email: params["customer_email"])
  end

  order = Order.new(user_id: session[:id], customer_id: customer[:id], sold_date: params["sold_date"], currency_type: params["currency_type"])

  if order.save

      venice_price_to_save = save_price_original(params["venice_price_paid_per_book_orig"])

      venice_item = OrderItem.create(quantity:  params["venice_quantity"], price_paid_per_book_orig: venice_price_to_save, book_id: 1, order_id: order[:id])

      prague_price_to_save = save_price_original(params["prague_price_paid_per_book_orig"])

      prague_item = OrderItem.create(quantity: params["prague_quantity"], price_paid_per_book_orig: prague_price_to_save, book_id: 2, order_id: order[:id])

      redirect "/users/#{session[:id]}/orders"

  else
    @errors = order.errors.full_messages
    erb :"orders/new"
  end

end

# combine all of the order detail views
# Orders LIST BY USER
get '/users/:user_id/orders' do
  @user = User.find(session[:id])
  @orders = @user.orders
  # @order_total = 0
  erb :'orders/index'
end

#{"base"=>"CZK", "date"=>"2016-08-11", "rates"=>{"GBP"=>0.031842, "USD"=>0.041277, "EUR"=>0.03701}}

# Orders LIST ALL
get '/orders' do
  @orders = Order.all

  @orders_all = true
  erb :'orders/index'
end

get '/orders/:id/edit' do
  @order = Order.find(params[:id])
  @customer = @order.customer
  @order_items = @order.order_items
  @order_items.each do |order_item|
    if order_item.book_id == 1 #is a venice order item
      @venice_quantity = order_item.quantity
      @venice_price_paid_per_book_orig = '%.2f' % (order_item.price_paid_per_book_orig / 100)
    elsif order_item.book_id == 2 #is a prague order item
      @prague_quantity = order_item.quantity
      @prague_price_paid_per_book_orig = '%.2f' % (order_item.price_paid_per_book_orig / 100)
    end
  end
  @errors = []
  erb :"orders/edit"
end

# Orders UPDATE
put '/orders/:id/edit' do
  @order = Order.find(params[:id])
  # @errors = []
  # if quantity does not exist for either venice or prague
  # p "*" * 80
  p params
  @customer = Customer.find_by(email: params["customer_email"])

  @customer.update_attributes(first_name: params["customer_first_name"], last_name: params["customer_last_name"], company: params["customer_company"], email: params["customer_email"])

  @order.update_attributes(sold_date: params["sold_date"], currency_type: params["currency_type"])

  @order_items = @order.order_items

  #if the order item exists, update it, if it doesn't exist, create a new one.
  venice_exists =  @order.order_items.any? { |order_item| order_item.book_id == 1 }
  p venice_exists
  @venice_item = @order.order_items.find_by(book_id: 1)
  p "*" * 80
  p @venice_item

  if venice_exists && params["venice_quantity"].to_i == 0
    p "I'm deleting the Venice item"
    @venice_item.destroy
  elsif venice_exists && params["venice_quantity"].to_i > 0
    p "I'm updating the Venice item"
    venice_price_to_save = save_price_original(params["venice_price_paid_per_book_orig"])
    venice_item.update_attributes(quantity: params["venice_quantity"], price_paid_per_book_orig: venice_price_to_save)
  elsif !venice_exists && params["venice_quantity"].to_i > 0
    p "I'm creating a new Venice item"
    venice_price_to_save = save_price_original(params["venice_price_paid_per_book_orig"])
    OrderItem.create(quantity: params["venice_quantity"], price_paid_per_book_orig: venice_price_to_save, book_id: 1, order_id: @order[:id])
  end

  prague_exists =  @order.order_items.any? { |order_item| order_item.book_id == 2 }
  @prague_item = @order.order_items.find_by(book_id: 2)

  if prague_exists && params["prague_quantity"].to_i == 0
    p "I'm deleting the Prague item"
    @prague_item.destroy
  elsif prague_exists && params["prague_quantity"].to_i > 0
    p "I'm updating the Prague item"
    prague_price_to_save = save_price_original(params["prague_price_paid_per_book_orig"])
    @prague_item.update_attributes(quantity: params["prague_quantity"], price_paid_per_book_orig: prague_price_to_save)
  elsif !prague_exists && params["prague_quantity"].to_i > 0
    p "I'm creating a new Prague item"
    prague_price_to_save = save_price_original(params["prague_price_paid_per_book_orig"])
    OrderItem.create(quantity: params["prague_quantity"], price_paid_per_book_orig: prague_price_to_save, book_id: 2, order_id: @order[:id])
  end

  @errors = check_for_errors(params)
  if @errors.length > 0
    return erb :"orders/edit"
  end

  redirect "/users/#{session[:id]}/orders"
end

# Orders DELETE
delete '/orders/:id' do
  order = Order.find(params[:id])
  p order
  if request.xhr?
     order.destroy
  end
  redirect "/users/#{session[:id]}/orders"
end
