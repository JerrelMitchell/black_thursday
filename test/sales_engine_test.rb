require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesEngineTest < Minitest::Test
  attr_reader :engine
  def setup
    @engine = SalesEngine.from_csv(
      items:     './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv',
      invoices:  './fixtures/fixture_invoices.csv',
      invoice_items: './fixtures/fixture_invoice_items.csv',
      transactions: './fixtures/fixture_transactions.csv',
      customers: './fixtures/fixture_customers.csv'
    )
  end

  def test_has_instances_of_item_and_merchant_repositories
    assert_instance_of ItemRepository, engine.items
    assert_instance_of MerchantRepository, engine.merchants
    assert_instance_of InvoiceRepository, engine.invoices
  end

  def test_it_has_attributes
    assert_equal '510+ RealPush Icon Set', engine.items.all.first.name
    assert_equal 'Shopin1901', engine.merchants.all.first.name
    assert_equal :pending, engine.invoices.all.first.status
    # assert_equal '', engine.transactions.all.first.credit_card_number
    # assert_equal '', engine.invoice_items.all.first.quantity
    # assert_equal '', engine.customers.all.first.first_name
  end
end
