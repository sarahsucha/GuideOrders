# Orders INDEX (list of all orders, regardless of user)

# Orders CREATE
get '/users/:user_id/orders/new' do
  @errors = []
  erb :'orders/new'
end

# Orders READ
post '/users/:id/orders' do
  @errors = []
  p "*" * 80
  p params
  #TODO how to update a customer - so we find their email... but let's say that now I know their last name, and fill it in (in the existing customer record, no last name is present). ALSO consider, as a user, maybe I want to be lazy and just enter the email address and not fill in the other information... in that case, I should select something if I want to update and then it will update the customer, otherwise it will just find by email and not update.
  # Also consider that I may have a repeating customer and not have their email address... or how do I update their email address (will need to be a future implementation of customer management and updating.)
  customer = Customer.find_by(email: params["customer_email"])
  if customer == nil
    customer = Customer.create(first_name: params["customer_first_name"], last_name: params["customer_last_name"], company: params["customer_company"], email: params["customer_email"])
  end

  order = Order.new(user_id: session[:id], customer_id: customer[:id], sold_date: params["sold_date"], currency_type: params["currency_type"])
  if order.save
    # if quantity does not exist for either venice or prague
    if (params["venice_quantity"] == "") && (params["prague_quantity"] == "")
      p "I'm in the venice and prague are both blank error"
      @errors << "Number of Venice or Prague books must be filled in"
    end

    # if venice quantity > 0, price paid must exist
    if params["venice_quantity"].to_i > 0 && (params["venice_price_paid_per_book_orig"] == "")
      p "I'm in the venice doesn't have a price error"
      @errors << "Venice book must have an original price"
    end

    if params["prague_quantity"].to_i > 0 && (params["prague_price_paid_per_book_orig"] == "")
      p "I'm in the prague doesn't have a price error"
      @errors << "Prague book must have an original price"
    end

    if @errors.length == 0
      p "I'm saving order items"
      venice_price_to_save = save_price_original(params["venice_price_paid_per_book_orig"])

      venice_item = OrderItem.create(quantity: params["venice_quantity"], price_paid_per_book_orig: venice_price_to_save, book_id: 1, order_id: order[:id])

      prague_price_to_save = save_price_original(params["prague_price_paid_per_book_orig"])

      prague_item = OrderItem.create(quantity: params["prague_quantity"], price_paid_per_book_orig: prague_price_to_save, book_id: 2, order_id: order[:id])

      redirect "/users/#{session[:id]}/orders"
    # else
    #   @errors
    #   erb :"orders/new"
    end
  else
    @errors = order.errors.full_messages
    # erb :"orders/new"
  end
  if @errors.length > 0
    erb :"orders/new"
  end 
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
