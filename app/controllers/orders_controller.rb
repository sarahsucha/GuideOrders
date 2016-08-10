# Orders INDEX (list of all orders, regardless of user)

# Orders NEW
get '/users/:user_id/orders/new' do
  erb :'orders/new'
end

# Orders CREATE
post '/orders' do
  #print out the date to see if in a format which can save to db
  #will get a number like $14.00 need to convert to 1400 to save to db
  p "I'm posting in orders"
  p (params)
  redirect "/users/#{session.id}/orders"
end

#TODO decide if will ask for sold date or if will use created_at - probably better to ask for sold date and use that on order view page.

# {"sold_date"=>"2016-08-10", "customer"=>{"first_name"=>"e", "last_name"=>"e", "company"=>"e", "email"=>"e@y.com"}, "order_item"=>{"quantity"=>"2", "currency_type"=>"EUR", "price_paid_per_book_orig"=>"13"}}


# Orders LIST BY USER
# Can use same erb page for list by user and list all, just change what data is passed from the db.
get '/users/:user_id/orders' do
  @user = User.find(session[:id])
  p @user
  @user_orders = @user.order_items
  p @user_orders
  erb :'orders/show'
end

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
# delete 'users/:user_id/orders/:id' do
#
# end
