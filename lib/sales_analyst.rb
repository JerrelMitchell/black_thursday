# :nodoc:
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class SalesAnalyst

  attr_reader :analyzed_items, :analyzed_merchants
  def initialize(sales_engine)
    @sales_engine       = sales_engine
    @analyzed_merchants = @sales_engine.merchants.all
    @analyzed_items     = @sales_engine.items.all
  end

  def average(numerator, denominator)
    (BigDecimal(numerator, 4) / BigDecimal(denominator, 4)).round(2)
  end

  def average_items_per_merchant
    average(analyzed_items.length, analyzed_merchants.length).to_f
  end

  def amount_of_items_per_merchant
    ids_array = analyzed_merchants.map(&:id)
    ids_array.map do |id|
      @sales_engine.items.find_all_by_merchant_id(id).count
    end
  end

  def standard_deviation(data, average)
    result = data.map do |item|
      (item - average)**2
    end.reduce(:+) / (data.length - 1)
    Math.sqrt(result)
  end


end
