require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesAnalystTest < Minitest::Test
  attr_reader :sales_analyst
  def setup
    engine = SalesEngine.from_csv(
      items:     './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv',
      invoices:  './fixtures/fixture_invoices.csv'
    )
    @sales_analyst = engine.analyst
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
  end

  def test_it_calculates_average_item_price_for_merchant_specified_by_id
    result = sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, result.class
    assert_equal 29.99, result.to_f
  end

  def test_it_calculates_standard_deviation_for_average_item_price
    result = sales_analyst.average_items_price_standard_deviation
    assert_equal Float, result.class
    assert_equal 374.65, result.to_f.round(2)
  end

  def test_it_calculates_average_item_price_for_all_merchants
    result = sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal, result.class
    assert_equal 26.87, result.to_f
  end

  def test_it_returns_collection_of_golden_items
    result = sales_analyst.golden_items
    assert_equal Array, result.class
    assert_equal Item, result.first.class
    assert_equal 2, result.size
  end

  def test_it_returns_total_invoices_for_merchants
    result = sales_analyst.total_invoices_for_merchants
    assert_equal Array, result.class
  end

  def test_it_returns_average_invoices_per_merchant
    result = sales_analyst.average_invoices_per_merchant
    assert_equal Float, result.class
    assert_equal 5.13, result
  end

  def test_it_calculates_standard_deviation_for_average_invoices_per_merchant
    result = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal Float, result.class
    assert_equal 4.84, result
  end

  def test_it_calculates_the_percentage_of_invoices_with_given_status
    result_1 = sales_analyst.invoice_status(:pending)
    assert_equal Float, result_1.class
    assert_equal 29.00, result_1

    result_2 = sales_analyst.invoice_status(:shipped)
    assert_equal Float, result_2.class
    assert_equal 59.5, result_2
  end

  def test_it_can_count_sales_per_day
    assert_instance_of Hash, sales_analyst.days_count
  end

  def test_it_can_find_standard_deviation_by_weekday
    assert_equal 5.66, sales_analyst.standard_deviation_of_invoices_by_wday
  end

  def test_it_can_return_top_weekday
    assert_equal "Saturday", sales_analyst.top_days_by_invoice_count
  end
end
