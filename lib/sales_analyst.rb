require_relative 'sales_engine'

class SalesAnalyst

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

 def average_items_per_merchant_standard_deviation
   standard_deviation(item, average(items.count, merchants.count))
 end

end
