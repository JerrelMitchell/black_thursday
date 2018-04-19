require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesAnalystTest < Minitest::Test
  attr_reader :sales_analyst
  def setup
    engine = SalesEngine.from_csv(
      items:         './fixtures/fixture_items.csv',
      merchants:     './fixtures/fixture_merchants.csv',
      invoices:      './fixtures/fixture_invoices.csv',
      invoice_items: './fixtures/fixture_invoice_items.csv',
      transactions:  './fixtures/fixture_transactions.csv',
      customers:     './fixtures/fixture_customers.csv'
    )
    @sales_analyst = engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_have_all_instances_of_merchants
    result = sales_analyst.merchants
    assert_equal 39,       result.size
    assert_equal Merchant, result.first.class
    assert_equal Merchant, result.last.class
  end

  def test_it_can_have_all_instances_of_items
    result = sales_analyst.items
    assert_equal 94,   result.size
    assert_equal Item, result.first.class
    assert_equal Item, result.last.class
  end

  def test_it_can_have_all_instances_of_invoices
    result = sales_analyst.invoices
    assert_equal 200,     result.size
    assert_equal Invoice, result.first.class
    assert_equal Invoice, result.last.class
  end

  def test_it_can_return_collection_of_item_prices
    result = sales_analyst.all_item_prices
    assert_equal 94,         result.size
    assert_equal BigDecimal, result.first.class
    assert_equal BigDecimal, result.last.class
    assert_equal 12.00,      result.first.to_f
  end

  def test_it_can_total_items_of_each_merchant_has_based_on_their_id
  end

  def test_it_can_total_invoices_of_each_merchant_has_based_on_their_id
  end

  def test_it_can_return_the_maximum_price_in_list_of_items
    result = sales_analyst.found_max_price
    assert_equal 3000, result
  end

  def test_it_gathers_items_with_matching_merchant_id
    assert_equal 12334141, sales_analyst.items.first.merchant_id
    result = sales_analyst.find_items_with_merchant_id(12334141)
    assert_equal Array, result.class
    assert_equal Item,  result.first.class
  end

  def test_it_gathers_invoices_with_matching_merchant_id
    assert_equal 12335938, sales_analyst.invoices.first.merchant_id
    result = sales_analyst.find_invoices_with_merchant_id(12335938)
    assert_equal Array,   result.class
    assert_equal Invoice, result.first.class
  end

  def test_it_gathers_invoice_items_with_matching_invoice_id
    assert_equal 1, sales_analyst.invoice_items.first.invoice_id
    result = sales_analyst.find_invoice_items_with_invoice_id(1)
    assert_equal Array,       result.class
    assert_equal InvoiceItem, result.first.class
  end

  def test_it_gathers_transactions_with_matching_invoice_id
    assert_equal 2179, sales_analyst.transactions.first.invoice_id
    result = sales_analyst.find_transactions_with_invoice_id(2179)
    assert_equal Array,       result.class
    assert_equal Transaction, result.first.class
  end

  def test_it_calculates_average_items_per_merchant
    result = sales_analyst.average_items_per_merchant
    assert_equal Float, result.class
    assert_equal 2.41,  result
  end

  def test_it_calculates_standard_deviation_for_average_items_per_merchant
    result = sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal Float, result.class
    assert_equal 2.90,  result
  end

  def test_it_returns_collection_of_merchants_with_high_item_counts
    result = sales_analyst.merchants_with_high_item_count
    assert_equal 2,        result.size
    assert_equal Merchant, result.first.class
  end

  def test_it_calculates_average_item_price_for_merchant_specified_by_id
    result = sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, result.class
    assert_equal 29.99,      result.to_f
  end

  def test_it_calculates_standard_deviation_for_average_item_price
    result = sales_analyst.average_items_price_standard_deviation
    assert_equal Float,  result.class
    assert_equal 374.65, result.round(2)
  end

  def test_it_calculates_standard_deviation_of_invoice_count
    result = sales_analyst.standard_deviation_of_invoice_count
    assert_equal 4.84, result.round(2)
  end

  def test_it_calculates_average_item_price_for_all_merchants
    result = sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal, result.class
    assert_equal 26.87,      result.to_f
  end

  def test_it_returns_collection_of_golden_items
    result = sales_analyst.golden_items
    assert_equal Array, result.class
    assert_equal Item,  result.first.class
    assert_equal 2,     result.size
  end

  def test_it_returns_average_invoices_per_merchant
    result = sales_analyst.average_invoices_per_merchant
    assert_equal Float, result.class
    assert_equal 5.13,  result
  end

  def test_it_calculates_standard_deviation_for_average_invoices_per_merchant
    result = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal Float, result.class
    assert_equal 4.84,  result
  end

  def test_it_calculates_the_percentage_of_invoices_with_given_status
    result1 = sales_analyst.invoice_status(:pending)
    assert_equal Float, result1.class
    assert_equal 29.00, result1

    result2 = sales_analyst.invoice_status(:shipped)
    assert_equal Float, result2.class
    assert_equal 59.5,  result2
  end

  def test_it_shows_top_merchants_by_invoice_count
    result = sales_analyst.top_merchants_by_invoice_count
    assert_equal [], result
  end

  def test_it_shows_bottom_merchants_by_invoice_count
    result = sales_analyst.bottom_merchants_by_invoice_count
    assert_equal [], result
  end

  def test_it_can_group_number_of_invoices_by_each_day_of_the_week
    result = sales_analyst.group_invoices_by_weekday
    assert_equal Hash, result.class
    assert_equal 7,    result.size
    assert_equal ({ 6 => 30,
                    5 => 35,
                    3 => 20,
                    1 => 26,
                    0 => 33,
                    2 => 33,
                    4 => 23 }), result
  end

  def test_it_can_find_standard_deviation_for_invoices_by_weekday
    result = sales_analyst.standard_deviation_of_invoices_by_weekday
    assert_equal 5.66, result
  end

  def test_it_can_return_top_invoicing_days
    result = sales_analyst.top_days_by_invoice_count
    assert_equal ['Friday'], result
    assert_equal 1,          result.size
  end

  def test_it_can_tell_if_invoice_is_paid_in_full
    assert sales_analyst.invoice_paid_in_full?(46)
    refute sales_analyst.invoice_paid_in_full?(1441)
  end

  def test_it_can_return_invoice_total
    result = sales_analyst.invoice_total(1)
    assert_equal 21067.77, result
  end

  def test_it_can_calculate_average
    sum = 12
    amount = 3
    assert_equal 4, sales_analyst.average(sum, amount)
  end

  def test_it_can_calculate_standard_deviation
    set = [3, 4, 5]
    average = sales_analyst.average(4, set.length)
    std_dev = sales_analyst.standard_deviation(set, average)
    assert_equal 3.42, std_dev.round(2)
  end
end
