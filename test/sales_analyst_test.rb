require './test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
<<<<<<< HEAD

  def setup
    @sales_analyst = SalesEngine.analyst
=======
  attr_reader :sales_engine, :sales_analyst
  def setup
    @sales_engine = SalesEngine.from_csv(
      items: './data/small_items.csv',
      merchants: './data/small_merchants.csv'
    )
    @sales_analyst = sales_engine.analyst
>>>>>>> wip
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_find_average_items_for_each_merchant
<<<<<<< HEAD
    assert_equal 0, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation_for_average_items_per_merchant
    assert_equal 0, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_average_item_price_for_merchant_returns_for_given_merchant
    assert_equal 0, @sales_analyst.average_item_price_for_merchant(@merchant.id)
    # according to spec harness, this method should be called
    # average_item_price_for_merchant and should return a BigDecimal
  end

  def test_it_returns_average_item_price_for_all_merchants
    assert_equal 0, @sales_analyst.average_average_price_per_merchant
    # according to spec harness, this method should be called
    # average_average_price_per_merchant and should return a BigDecimal
  end

  def test_it_can_find_merchants_with_high_item_count
    assert_equal ['merchant 1', 'merchant 2'], @sales_analyst.merchants_with_high_item_count
    # more than one standard deviation above the average number of products offered
  end

  def test_it_returns_golden_items
    assert_equal ['golden item 1', 'golden item 2'], @sales_analyst.golden_items
    # golden items are two standard deviations above average price
    # this method should return an array
  end

=======
    assert_equal 2.41, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation_for_average_items_per_merchant
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

#   def test_average_item_price_for_merchant_returns_for_given_merchant
#     skip
#     assert_equal 0, @sales_analyst.average_item_price_for_merchant(@merchant.id)
#     # according to spec harness, this method should be called
#     # average_item_price_for_merchant and should return a BigDecimal
#   end
#
#   def test_it_returns_average_item_price_for_all_merchants
#     skip
#     assert_equal 0, @sales_analyst.average_average_price_per_merchant
#     # according to spec harness, this method should be called
#     # average_average_price_per_merchant and should return a BigDecimal
#   end
#
#   def test_it_can_find_merchants_with_high_item_count
#     skip
#     assert_equal ['merchant 1', 'merchant 2'], @sales_analyst.merchants_with_high_item_count
#     # more than one standard deviation above the average number of products offered
#   end
#
#   def test_it_returns_golden_items
#     skip
#     assert_equal ['golden item 1', 'golden item 2'], @sales_analyst.golden_items
#     # golden items are two standard deviations above average price
#     # this method should return an array
#   end
#
>>>>>>> wip
end
