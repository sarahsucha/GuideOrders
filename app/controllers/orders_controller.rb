# Orders INDEX (list of all orders, regardless of user)

# Orders CREATE
get '/users/:user_id/orders/new' do
  erb :'orders/new'
end

# Orders READ
post '/users/:id/orders' do
  p "*" * 80
  p params
  p params["customer_email"]
  #TODO how to update a customer - so we find their email... but let's say that now I know their last name, and fill it in (in the existing customer record, no last name is present). ALSO consider, as a user, maybe I want to be lazy and just enter the email address and not fill in the other information... in that case, I should select something if I want to update and then it will update the customer, otherwise it will just find by email and not update.
  # Also consider that I may have a repeating customer and not have their email address... or how do I update their email address (will need to be a future implementation of customer management and updating.)
  customer = Customer.find_by(email: params["customer_email"])
  if customer == nil
    customer = Customer.create(first_name: params["customer_first_name"], last_name: params["customer_last_name"], company: params["customer_company"], email: params["customer_email"])
  end
  order = Order.new(sold_by_id: session[:id], customer_id: customer[:id], sold_date: params["sold_date"], currency_type: params["currency_type"])
  if order.save
    #TODO will get a number like 14.00 need to convert to 1400 to save to db
    venice_item = OrderItem.new(quantity: params["venice_quantity"], price_paid_per_book_orig: params["venice_price_paid_per_book_orig"], book_id: 1, order_id: order[:id])
    prague_item = OrderItem.new(quantity: params["prague_quantity"], price_paid_per_book_orig: params["prague_price_paid_per_book_orig"], book_id: 2, order_id: order[:id])
    if venice_item.save && prague_item.save
      redirect "/users/#{session[:id]}/orders"
    else
      @venice_errors = venice_item.errors.full_messages
      @prague_errors = prague_item.errors.full_messages
      erb :"orders/new"
    end
  else
    @order_errors = order.errors.full_messages
    erb :"orders/new"
  end
end

#TODO decide if will ask for sold date or if will use created_at - probably better to ask for sold date and use that on order view page.

# {"sold_date"=>"2016-08-10", "customer"=>{"first_name"=>"e", "last_name"=>"e", "company"=>"e", "email"=>"e@y.com"}, "order_item"=>{"quantity"=>"2", "currency_type"=>"EUR", "price_paid_per_book_orig"=>"13"}}

# {"sold_date"=>"2016-08-11", "customer"=>{"first_name"=>"sarah", "last_name"=>"sucha", "company"=>"Lizard Ranch", "email"=>"sarah_deutschland@hotmail.com"}, "order_item"=>{"quantity"=>"2", "currency_type"=>"EUR", "price_paid_per_book_orig"=>"13"}, "splat"=>[], "captures"=>["1"], "id"=>"1"}


# Orders LIST BY USER
# Can use same erb page for list by user and list all, just change what data is passed from the db.
get '/users/:user_id/orders' do
  @user = User.find(session[:id])
  @user_orders = @user.orders
  # @order_total = 0
  erb :'orders/show'
end

# <% @order_total += order_item.quantity * order_item.price_paid_per_book_orig %>
#
#
# #<ActiveRecord::Associations::CollectionProxy [#<Order id: 1, sold_by_id: 1, customer_id: 1, sold_date: "2015-12-01", is_reconciled: false>]>

# irb(main):002:0> Order.last.order_items
# D, [2016-08-12T17:26:49.498890 #5343] DEBUG -- :   Order Load (2.7ms)  SELECT  "orders".* FROM "orders"  ORDER BY "orders"."id" DESC LIMIT 1
# D, [2016-08-12T17:26:49.525624 #5343] DEBUG -- :   OrderItem Load (18.9ms)  SELECT "order_items".* FROM "order_items" WHERE "order_items"."order_id" = $1  [["order_id", 1]]
# => #<ActiveRecord::Associations::CollectionProxy [#<OrderItem id: 1, quantity: 1, currency_type: "USD", price_paid_per_book_orig: 1400, book_id: 1, order_id: 1, czk_conversion_id: nil, created_at: "2016-08-07 20:15:53", updated_at: "2016-08-07 20:15:53">]>
# irb(main):003:0>

#<OrderItem id: 1, quantity: 1, currency_type: "USD", price_paid_per_book_orig: 1400, book_id: 1, order_id: 1, czk_conversion_id: nil, created_at: "2016-08-07 20:15:53", updated_at: "2016-08-07 20:15:53">]

# # Orders LIST ALL
# get '/orders' do
#
# end
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
