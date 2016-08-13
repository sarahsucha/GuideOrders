helpers do
  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  def save_price_original(entered_price)
    #say entered price = "14.5555"
    (entered_price.to_f.round(2) * 100).to_i
  end
end
