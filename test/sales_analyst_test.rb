require './test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @analyst = SalesEngine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
  end

  def test_it_can_find_average_items_for_each_merchant
    assert_equal 4, @merchants.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation_for_average_items_per_merchant

  end

  def test_average_item_price_for_merchant_returns_for_given_merchant
    # method should be called average item price for merchant
  end

  def test_it_returns_average_item_price_for_all_merchants
    # method should be called "average price per merchant"
  end

  def test_it_can_find_merchants_with_high_item_count
    # more than one standard deviation above the average number of products offered
  end

  def test_it_returns_golden_items
    # golden items are two standard deviations above average price
  end

end
