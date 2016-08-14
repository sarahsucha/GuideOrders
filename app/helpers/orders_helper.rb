helpers do

  def save_price_original(entered_price)
    #say entered price = "14.5555"
    (entered_price.to_f.round(2) * 100).to_i
  end

  def display_order_total(order)
    '%.2f' % order.order_total
  end

  def display_total_czk(order)
    currency = order.currency_type
    date = "#{order.sold_date.year}-#{order.sold_date.month}-#{order.sold_date.day}"
    resp = RestClient.get 'http://api.fixer.io/latest', {:params => {:symbols => currency, :base => "CZK", :date => date}}
    currency_exchange = JSON.parse(resp.body)
    p "*" * 80
    p currency_exchange["rates"]["#{currency}"]
    order.convert_to_czk(currency_exchange["rates"]["#{currency}"]).round
  end

end
