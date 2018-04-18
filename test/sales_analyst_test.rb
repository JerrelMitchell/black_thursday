require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesAnalystTest < Minitest::Test
  attr_reader :sales_analyst
  def setup
    engine = SalesEngine.from_csv(
      items:     './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv',
      invoices:  './fixtures/fixture_invoices.csv',
      invoice_items: './fixtures/fixture_invoice_items.csv',
      transactions: './fixtures/fixture_transactions.csv',
      customers: './fixtures/fixture_customers.csv'
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
    result1 = sales_analyst.invoice_status(:pending)
    assert_equal Float, result1.class
    assert_equal 29.00, result1

    result2 = sales_analyst.invoice_status(:shipped)
    assert_equal Float, result2.class
    assert_equal 59.5, result2
  end

  def test_it_can_group_number_of_invoices_by_each_day_of_the_week
    result = sales_analyst.group_invoices_by_weekday
    assert_equal Hash, result.class
    assert_equal 7, result.size
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
    assert_equal 1, result.size
    assert_equal ['Friday'], result
  end

  def test_it_can_tell_if_invoice_is_paid_in_full
    invoice_1 = Invoice.new({
      id:           9,
      customer_id:  '6',
      merchant_id:  '2',
      status:       'paid in full',
      created_at:   '2018-09-04',
      updated_at:   '2018-09-04'
    }, 'parent')

    assert sales_analyst.invoice_paid_in_full?('4')

    invoice_2 = Invoice.new({
      id:            '7',
      customer_id:   '5',
      merchant_id:   '2',
      status:        'pending',
      created_at:   '2018-09-04',
      updated_at:   '2018-09-04'
      }, 'parent')

      refute sales_analyst.invoice_paid_in_full?('7')
  end
end
