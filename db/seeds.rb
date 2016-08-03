Book.create(title: "A Rabbit's Guide to Venice", printing_cost_czk: 150.00, isbn: "978-3-16-148410-0", publish_date: DateTime.new(2013, 12, 10))

Customer.create(first_name: "Jessica", last_name: "Gilpin", company: "Amadito and Friends", email: "jessica@sun-state.com")

Order.create(sold_by: "Sarah", book_id: 1, customer_id: 1, currency: "usd", price_paid_per_book_orig: 14.00, amount: 1)
