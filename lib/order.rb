require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise "id must be a number." if id < 1
    raise "products must be a hash" if products.class != Hash
    raise ArgumentError, "invalid fulfillment_status" unless [:pending, :paid, :processing, :shipped, :complete, nil].include? fulfillment_status

  end

  def total
    if products.values.all? nil
      total = "You don't have any products, your total is $0.00"
      return total
    end
    product_total = products.values.reduce(:+)
    product_total * 0.075
    total = format("$%.2f", product_total)
    return total
  end

  def add_product(product_name, price)
    Order[:products] << products[product_name, price]
    return Order
  end
end

kayla = Order.new(45678, {}, "Kayla")
pp kayla.total




# kayla_order = Order.new(4534, {}, "Kayla", :invalid)
# pp kayla_order