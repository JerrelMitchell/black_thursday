require_relative '../modules/math_wizard'
require_relative '../modules/repository'

# :nodoc:
class SalesAnalyst
  include MathWizard
  include Repository
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

  def found_max_price
    all_item_prices.max.to_i
  end

  def find_items_with_merchant_id(id)
    sales_engine.items.find_all_by_merchant_id(id)
  end

  def find_invoices_with_merchant_id(id)
    sales_engine.invoices.find_all_by_merchant_id(id)
  end

  def find_invoice_items_with_invoice_id(id)
    sales_engine.invoice_items.find_all_by_invoice_id(id)
  end

  def find_transactions_with_invoice_id(id)
    sales_engine.transactions.find_all_by_invoice_id(id)
  end

  def total_items_for_merchants
    merchants.map do |merchant|
      find_items_with_merchant_id(merchant.id).length
    end
  end

  def total_invoices_for_merchants
    merchants.map do |merchant|
      find_invoices_with_merchant_id(merchant.id).length
    end
  end

  def average_invoices_per_merchant
    average(invoices.length, merchants.length).to_f
  end

  def average_items_per_merchant
    average(items.length, merchants.length).to_f
  end

  def average_items_price_standard_deviation
    standard_deviation(all_item_prices, average_average_price_per_merchant)
  end

  def standard_deviation_of_item_price
    standard_deviation(all_item_prices, average_average_price_per_merchant)
  end

  def standard_deviation_of_invoice_count
    standard_deviation(total_invoices_for_merchants,
                       average_average_invoices_per_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_list = total_invoices_for_merchants
    standard_deviation(invoice_list, average_invoices_per_merchant).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(total_items_for_merchants,
                       average_items_per_merchant).round(2)
  end

  def top_days_by_invoice_count
    find_top_days.keys.map { |day| Date::DAYNAMES[day] }
  end

  def average_item_price_for_merchant(id)
    return 0 if find_items_with_merchant_id(id).length.zero?
    instance_items = find_items_with_merchant_id(id)
    prices = instance_items.map(&:unit_price)
    average(prices.reduce(:+), instance_items.length)
  end

  def average_average_price_per_merchant
    result = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(result, merchants.length)
  end

  def invoice_status(status)
    matching_invoices = invoices.find_all do |invoice|
      invoice.attributes[:status] == status
    end
    ((matching_invoices.length.to_f / invoices.length) * 100).round(2)
  end

  def golden_items
    item_price_deviation = standard_deviation_of_item_price
    item_price = average_average_price_per_merchant + (2 * item_price_deviation)
    price_range = item_price.to_i..found_max_price
    sales_engine.items.find_all_by_price_in_range(price_range)
  end

  def merchants_with_high_item_count
    average_items = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    merchants.collect do |merchant|
      average_difference = (find_items_with_merchant_id(merchant.id).length - average_items)
      merchant if average_difference > standard_deviation
    end.compact
  end

  def top_merchants_by_invoice_count
    invoices_deviation = average_invoices_per_merchant_standard_deviation
    average_invoices = average_invoices_per_merchant
    bottom_range = (invoices_deviation * 2) + average_invoices
    merchants.map do |merchant|
      merchant if find_invoices_with_merchant_id(merchant.id).length > bottom_range
    end.compact
  end

  def bottom_merchants_by_invoice_count
    invoices_deviation = average_invoices_per_merchant_standard_deviation
    average_invoices = average_invoices_per_merchant
    bottom_range = average_invoices - (invoices_deviation * 2)
    merchants.map do |merchant|
      merchant if find_invoices_with_merchant_id(merchant.id).length < bottom_range
    end.compact
  end

  def group_invoices_by_weekday
    days = @sales_engine.invoices.all.map { |invoice| invoice.created_at.wday }
    group = days.group_by { |day| day }
    group.each { |key, value| group[key] = value.length }
  end

  def find_top_days
    average = group_invoices_by_weekday.values.inject(:+) / 7
    std_dev = standard_deviation_of_invoices_by_weekday
    amount = std_dev + average
    group_invoices_by_weekday.reject do |_, value|
      value < amount
    end
  end

  def standard_deviation_of_invoices_by_weekday
    average = group_invoices_by_weekday.values.inject(:+) / 7
    total_invoices_by_day = group_invoices_by_weekday.values
    squared_num_invoice = total_invoices_by_day.map { |day| (day - average)**2 }
    value = squared_num_invoice.inject(:+) / (total_invoices_by_day.length - 1)
    Math.sqrt(value).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = find_transactions_with_invoice_id(invoice_id)
    transactions.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items = find_invoice_items_with_invoice_id(invoice_id)
    total_of_all_items = invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end.reduce(:+)
    total_of_all_items
  end
end
