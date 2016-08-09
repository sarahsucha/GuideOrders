# Orders INDEX (list of all orders, regardless of user)

# Orders NEW
get '/users/:user_id/order/new' do
  erb :'orders/new'
end

# Orders CREATE
# post '/orders' do
#   #print out the date to see if in a format which can save to db
#   #will get a number like $14.00 need to convert to 1400 to save to db
#
# end
