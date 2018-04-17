require_relative 'math_wizard'
# :nodoc:
class SalesAnalyst
  include MathWizard
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end
  def merchants
    sales_engine.merchants.all
  end
  def items
    sales_engine.items.all
  end
  def invoices
    sales_engine.invoices.all
  end
  def all_item_prices
    items.map(&:unit_price)
  end
  def find_items_with_merchant_id(id)
    sales_engine.merchants.find_by_id(id).items
  end

  def find_invoices_with_merchant_id(id)
    sales_engine.invoices.find_all_by_merchant_id(id)
  end

  def average_items_per_merchant
    average(items.length, merchants.length).to_f
  end

  def average_items_per_merchant_standard_deviation
    all_items = merchants.map { |merchant| merchant.items.length }
    standard_deviation(all_items, average_items_per_merchant).round(2)
  end

  def average_items_price_standard_deviation
    standard_deviation(all_item_prices, average_average_price_per_merchant)
  end

  def merchants_with_high_item_count
    average_items = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    merchants.collect do |merchant|
      average_difference = (merchant.items.length - average_items)
      merchant if average_difference > standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    return 0 if find_items_with_merchant_id(id).length.zero?
    instance_items = sales_engine.collect_items_by_merchant_id(id)
    prices = instance_items.map(&:unit_price)
    average(prices.reduce(:+), instance_items.length)
  end

  def average_average_price_per_merchant
    result = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(result, merchants.length)
  end

  def found_max_price
    @sales_engine.items.all.map(&:unit_price).max.to_i
  end

  def prices_list
    @sales_engine.items.all.map(&:unit_price)
  end

  def standard_deviation_of_item_price
    standard_deviation(prices_list, average_average_price_per_merchant)
  end

  def golden_items
    item_price_deviation = standard_deviation_of_item_price
    item_price = average_average_price_per_merchant + (2 * item_price_deviation)
    price_range = item_price.to_i..found_max_price
    @sales_engine.items.find_all_by_price_in_range(price_range)
  end

  def total_invoices_for_merchants
    merchants.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant.id).invoices.length
    end
  end

  def average_invoices_per_merchant
    average(invoices.length, merchants.length).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_list = total_invoices_for_merchants
    standard_deviation(invoice_list, average_invoices_per_merchant).round(2)
  end

  def invoice_status(status)
    matching_invoices = invoices.find_all do |invoice|
      invoice.attributes[:status] == status
    end
    ((matching_invoices.length.to_f / invoices.length) * 100).round(2)
  end

  def standard_deviation_of_invoice_count
    standard_deviation(total_invoices_for_merchants, average_average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    bottom_range = (std_dev * 2) + average
    sales_engine.merchants.all.map do |merchant|
      amount = sales_engine.merchants.find_by_id(merchant.id).invoices.length
      merchant if amount > bottom_range
    end.compact
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    bottom_of_range = average - (std_dev * 2)
    @sales_engine.merchants.all.map do |merchant|
      amount = @sales_engine.merchants.find_by_id(merchant.id).invoices.length
      merchant if amount < bottom_of_range
    end.compact
  end

  def days_count
    days = invoices.map do |invoice|
      invoice.created_at.wday
    end
    grouped = days.group_by do |day|
      day
    end
    grouped.each do |key, value|
      grouped[key] = value.length
      #binding.pry
    end
  end

  def standard_deviation_of_invoices_by_wday
    average = days_count.values.reduce(:+) / 7
    total_by_day = days_count.values
    squared = total_by_day.map do |day|
      (day - average) ** 2
    end
    #binding.pry
    value = squared.reduce(:+) / (total_by_day.length - 1)
    Math.sqrt(value).round(2)
  end

  def days_sales
    average = days_count.values.reduce(:+) / 7
    standard_deviation = standard_deviation_of_invoices_by_wday
    amount = standard_deviation + average
    days_count.select do |amount, value|
      value > amount
      binding.pry
    end
  end

  def top_days_by_invoice_count
    days_sales.keys.map do |day|
      Date::DAYNAMES[day]
    end
  end

end
