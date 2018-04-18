require './test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repo
  def setup
    engine = SalesEngine.from_csv(
      items:     './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv',
      invoices:  './fixtures/fixture_invoices.csv',
      invoice_items: './fixtures/fixture_invoice_items.csv',
      transactions: './fixtures/fixture_transactions.csv',
      customers: './fixtures/fixture_customers.csv'
    )
      @customer_repo = engine.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repo
  end

  def test_it_can_find_all_by_first_name
    assert_equal 1, @customer_repo.find_all_by_first_name('Sylvester')

    assert_equal 1, @customer_repo.find_all_by_first_name('Will')
  end

  def test_it_can_find_all_by_last_name
    assert_equal 1, @customer_repo.find_all_by_last_name('Armstrong')

    assert_equal 1, @customer_repo.find_all_by_last_name('Ortiz')
  end

  def test_find_all_by_first_or_last_name_are_case_insensitive
    assert_equal 1, @customer_repo.find_all_by_first_name('sylvester')

    assert_equal 1, @customer_repo.find_all_by_last_name('ortiz')
  end

  def test_it_can_create_a_new_customer_with_given_attributes
    assert_nil @customer_repo.find_by_id(201)

    @customer_repo.create({id: '201', first_name: 'Bob', last_name: 'Ross', created_at: '2018-05-05 UPC', updated_at: '2018-05-06 UPC')
    result = @customer_repo.find_by_id(201)
    assert_equal 201, result.id
    assert_equal 'Bob', result.first_name
  end

  def test_it_can_update_customer
    result = @customer_repo.find_by_id(1)
    assert_equal 'Joey', result.first_name
    assert_equal 'Ondricka', result.last_name

    @customer_repo.update(1, {id: '1', first_name: 'Joe', last_name: 'Ondrick', created_at: '2018-05-05 UPC', updated_at: '2018-05-06 UPC'})
  end
end
