require './test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesAnalystTest < Minitest::Test
  attr_reader :sales_analyst
  def setup
    @engine = SalesEngine.from_csv(items: './data/small_items.csv',
                                   merchants: './data/small_merchants.csv')
    @sales_analyst = @engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_calculates_average_items_per_merchant
    result = sales_analyst.average_items_per_merchant
    assert_equal Float, result.class
    assert_equal 2.41, result
  end

  def test_it_calculates_standard_deviation_for_average_items_per_merchant
    result = sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal Float, result.class
    assert_equal 2.90, result
  end

  def test_it_returns_collection_of_merchants_with_high_item_counts
    result = sales_analyst.merchants_with_high_item_count
    assert_equal 2, result.size
    assert_equal Merchant, result.first.class
    # more than one standard deviation above the
    # average number of products offered
  end

  def test_it_calculates_average_item_price_for_merchant_specified_by_id
    result = sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, result.class
    assert_equal 29.99, result.to_f
    # according to spec harness, this method should be called
    # average_item_price_for_merchant and should return a BigDecimal
  end

  def test_it_calculates_average_item_price_for_all_merchants
    skip
    result = sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal, result.class
    assert_equal 0, result.to_f
    # according to spec harness, this method should be called
    # average_average_price_per_merchant and should return a BigDecimal
  end

  def test_it_returns_collection_golden_items
    skip
    result = sales_analyst.golden_items
    assert_equal Array, result.class
    assert_equal Item, result.first.class
    assert_equal 5, result.size
    # golden items are two standard deviations above average price
    # this method should return an array
  end
end
