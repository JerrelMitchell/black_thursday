require './test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repo
  def setup
      engine = SalesEngine.from_csv(
        items:     './fixtures/fixture_items.csv',
        merchants: './fixtures/fixture_merchants.csv',
        invoices:  './fixtures/fixture_invoices.csv',
        customers: './fixtures/fixture_customers.csv'
      )
      @customer_repo = engine.customers
  end

  def test_it_exists
    assert_instance_of Customer, customer_repo
  end

end
