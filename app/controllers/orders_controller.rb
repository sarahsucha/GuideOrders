# Orders INDEX (list of all orders, regardless of user)

# Orders NEW
get '/users/:user_id/orders/new' do
  erb :'orders/new'
end

# Orders CREATE
post '/users/:id/orders' do
# post '/orders' do
  #print out the date to see if in a format which can save to db
  #will get a number like $14.00 need to convert to 1400 to save to db
  p "I'm posting in orders"
  p "*" * 80
  p (params)
  # customer = Customer.new(first_name: params[:first_name], last_name: params[:last_name], company: params[:company], email: params[:email])
  customer = Customer.new(params[:customer])
  # must save the customer before can get the customer id
  order = Order.new(sold_by_id: session[:id], customer_id: customer[:id], sold_date: params["sold_date"])
  # for each of the order items - must save the order before can get the order id
  venice_item = OrderItem.new(params[:order_item], book_id: 1, order_id: order[:id], quantity: params["venice_quantity"])
  prague_item = OrderItem.new(params[:order_item], book_id: 2, order_id: order[:id], quantity: params["prague_quantity"])
  p "*" * 80
  p customer
  p "*" * 80

  p order
  # create a new customer
  # create a new order
  # create new order items
  redirect "/users/#{session[:id]}/orders"
end

#TODO decide if will ask for sold date or if will use created_at - probably better to ask for sold date and use that on order view page.

# {"sold_date"=>"2016-08-10", "customer"=>{"first_name"=>"e", "last_name"=>"e", "company"=>"e", "email"=>"e@y.com"}, "order_item"=>{"quantity"=>"2", "currency_type"=>"EUR", "price_paid_per_book_orig"=>"13"}}

# {"sold_date"=>"2016-08-11", "customer"=>{"first_name"=>"sarah", "last_name"=>"sucha", "company"=>"Lizard Ranch", "email"=>"sarah_deutschland@hotmail.com"}, "order_item"=>{"quantity"=>"2", "currency_type"=>"EUR", "price_paid_per_book_orig"=>"13"}, "splat"=>[], "captures"=>["1"], "id"=>"1"}


# Orders LIST BY USER
# Can use same erb page for list by user and list all, just change what data is passed from the db.
get '/users/:user_id/orders' do
  @user = User.find(session[:id])
  p @user
  @user_orders = @user.orders
  p @user_orders
  erb :'orders/show'
end

#<ActiveRecord::Associations::CollectionProxy [#<Order id: 1, sold_by_id: 1, customer_id: 1, sold_date: "2015-12-01", is_reconciled: false>]>

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
# # Orders EDIT
# put 'users/:user_id/orders/:id/edit' do
#
# end
#
# # Orders DELETE
# delete 'users/:userid/orders/:id' do
#
# end
