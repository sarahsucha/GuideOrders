Book.create(title: "A Rabbit's Guide to Venice", printing_cost_czk: 150, isbn: "978-3-16-148410-0", publish_date: DateTime.new(2013, 12, 10), inventory: 100, original_inventory: 300)

Book.create(title: "A Rabbit's Guide to Prague", printing_cost_czk: 151, isbn: "978-3-16-148410-0", publish_date: DateTime.new(2015, 12, 10), inventory: 400, original_inventory: 700)


Customer.create(first_name: "Jessica", last_name: "Gilpin", company: "Amadito and Friends", email: "jessica@sun-state.com")

User.create(first_name: "Sarah", last_name: "Sucha", password: "123")

Order.create(sold_by_id: 1, customer_id: 1)

OrderItem.create(quantity: 1, currency_type: "USD", price_paid_per_book_orig: 1400, book_id: 1, order_id: 1)

OrderItem.create(quantity: 2, currency_type: "CZK", price_paid_per_book_orig: 200, book_id: 2, order_id: 2)
