# Session NEW
# TODO get '/login'
get '/login' do
  #session.destroy
  erb :"sessions/new"
end

# Session CREATE
post '/sessions' do
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
    session[:id] = @user.id
    redirect "/users/#{@user.id}/orders/new"
  else
    @errors = ["Wrong email or password, please try logging in again"]
    erb :"sessions/new"
  end
end

# Session DELETE
delete '/sessions' do
  session[:id] = nil
  redirect '/'
end
