require_relative 'sales_engine'

class SalesAnalyst

<<<<<<< HEAD
  def initialize

  end

  def average_items_per_merchant
    @merchants.reduce(0) do |merchant|
      merchant.items.length #can we use reduce here??
    end
    # find average items per merchant
  end

  def merchants_with_high_item_count
    @merchants.sort_by do |merchant|
      merchant.items.length
    end
  end

=======
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def average(numerator, denominator)
    (BigDecimal(numerator, 4) / BigDecimal(denominator, 4)).round(2)
  end

  def standard_deviation(data, average)
   result = data.map do |item|
     binding.pry
     (item - average)**2
   end.reduce(:+) / (data.length - 1)
   Math.sqrt(result)
 end

 def average_items_per_merchant
   average(items.length, merchants.length).to_f
 end

 def numbers_of_items_per_merchant
   ids_array = merchants.map(&:id)
   ids_array.map do |id|
     @sales_engine.items.find_all_by_merchant_id(id).count
   end
 end

 def average_items_per_merchant_standard_deviation
   standard_deviation(numbers_of_items_per_merchant)
   average(items.count, merchants.count)
 end
>>>>>>> wip

end
