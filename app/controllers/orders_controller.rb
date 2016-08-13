# Orders INDEX (list of all orders, regardless of user)

# Orders CREATE
get '/users/:user_id/orders/new' do
  erb :'orders/new'
end

# Orders READ
post '/users/:id/orders' do
  #TODO how to update a customer - so we find their email... but let's say that now I know their last name, and fill it in (in the existing customer record, no last name is present). ALSO consider, as a user, maybe I want to be lazy and just enter the email address and not fill in the other information... in that case, I should select something if I want to update and then it will update the customer, otherwise it will just find by email and not update.
  # Also consider that I may have a repeating customer and not have their email address... or how do I update their email address (will need to be a future implementation of customer management and updating.)
  customer = Customer.find_by(email: params["customer_email"])
  if customer == nil
    customer = Customer.create(first_name: params["customer_first_name"], last_name: params["customer_last_name"], company: params["customer_company"], email: params["customer_email"])
  end
  order = Order.new(user_id: session[:id], customer_id: customer[:id], sold_date: params["sold_date"], currency_type: params["currency_type"])
  if order.save
    venice_price_to_save = save_price_original(params["venice_price_paid_per_book_orig"])
    venice_item = OrderItem.new(quantity: params["venice_quantity"], price_paid_per_book_orig: venice_price_to_save, book_id: 1, order_id: order[:id])
    if venice_item.quantity != nil
      p "I'm saving a Venice item"
      venice_item.save
    end
    prague_price_to_save = save_price_original(params["prague_price_paid_per_book_orig"])
    prague_item = OrderItem.new(quantity: params["prague_quantity"], price_paid_per_book_orig: prague_price_to_save, book_id: 2, order_id: order[:id])
    if prague_item.quantity != nil
      p "I'm saving a Prague item"
      prague_item.save
    end
    redirect "/users/#{session[:id]}/orders"
  else
    @order_errors = order.errors.full_messages
    erb :"orders/new"
  end
    #TODO need to validate that either venice or prague must have a quantity in order to make an order
    #TODO need to validate that if a quantity is entered in either venice or prague, must enter number of books sold.
    # if venice_item.save && prague_item.save
    #   redirect "/users/#{session[:id]}/orders"
    # else
    #   @venice_errors = venice_item.errors.full_messages
    #   @prague_errors = prague_item.errors.full_messages
    #   erb :"orders/new"
    # end
end

# Orders LIST BY USER
get '/users/:user_id/orders' do
  @user = User.find(session[:id])
  @orders = @user.orders
  # @order_total = 0
  erb :'orders/show'
end

# Orders LIST ALL
get '/orders' do
  @orders = Order.all
  @orders_all = true
  erb :'orders/show'
end
#
# # Orders UPDATE
# put 'users/:user_id/orders/:id/edit' do
#
# end
#
# # Orders DELETE
# delete 'users/:userid/orders/:id' do
#
# end
