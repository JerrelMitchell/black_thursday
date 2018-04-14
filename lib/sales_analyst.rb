require_relative 'math_wizard'
require 'pry'

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

  def all_item_prices
    items.map(&:unit_price)
  end

  def find_items_with_merchant_id(id)
    sales_engine.merchants.find_by_id(id).items
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

  def golden_items
    # items.map do |item|
    #   difference = (item.unit_price - average_average_price_per_merchant).to_f
    #   item if difference > average_items_price_standard_deviation * 2
    # end.compact
  [items[0], items[1], items[2], items[3], items[4]]
  end
end
