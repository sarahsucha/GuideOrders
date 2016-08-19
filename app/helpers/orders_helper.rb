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
    p "currency"
    p currency
    date = "#{order.sold_date.year}-#{order.sold_date.month}-#{order.sold_date.day}"
    p date
    resp = RestClient.get 'http://api.fixer.io/latest', {:params => {:symbols => currency, :base => "CZK", :date => date}}
    currency_exchange = JSON.parse(resp.body)
    p "*" * 80
    p currency_exchange["rates"]["#{currency}"]
    order.convert_to_czk(currency_exchange["rates"]["#{currency}"]).round
  end

  def check_for_errors(params)
    @errors = []

    if (params["venice_quantity"] == "") && (params["prague_quantity"] == "")
      p "I'm in the if that no venice or prague has been selected"
      @errors << "Number of Venice or Prague books must be filled in"
    end

    # if venice quantity > 0, price paid must exist
    if params["venice_quantity"].to_i > 0 && (params["venice_price_paid_per_book_orig"] == "")
      # p "I'm in the if that venice price has not been entered"
      @errors << "Venice book must have an original price"
    end

    if params["prague_quantity"].to_i > 0 && (params["prague_price_paid_per_book_orig"] == "")
      # p "I'm in the if that prague price has not been entered"
      @errors << "Prague book must have an original price"
    end

    if params["venice_price_paid_per_book_orig"] != "" && params["venice_quantity"] == ""
      @errors << "Please add a Venice quantity"
    end

    if params["prague_price_paid_per_book_orig"] != "" && params["prague_quantity"] == ""
      @errors << "Please add a Prague quantity"
    end

    @errors
  end

end
