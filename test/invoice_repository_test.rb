require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repo
  def setup
    engine = SalesEngine.from_csv(
      items:     './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv',
      invoices:  './fixtures/fixture_invoices.csv',
      invoice_items: './fixtures/fixture_invoice_items.csv',
      transactions: './fixtures/fixture_transactions.csv',
      customers: './fixtures/fixture_customers.csv'
    )
    @invoice_repo = engine.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, invoice_repo
  end

  def test_it_has_all_invoices_in_array_and_all_invoices_are_invoices
    assert_instance_of Array, invoice_repo.all
    assert_equal 200, invoice_repo.all.count
    assert(invoice_repo.all.all? { |invoice| invoice.is_a?(Invoice) })
  end

  def test_it_can_find_specified_invoice_by_id
    result1 = invoice_repo.find_by_id(28)
    assert_equal 28, result1.id

    result2 = invoice_repo.find_by_id(44)
    assert_equal 44, result2.id

    result3 = invoice_repo.find_by_id(0)
    assert_nil result3
  end

  def test_it_can_find_all_instances_of_invoices_by_status
    assert_equal [], invoice_repo.find_all_by_status('INVALID EXAMPLE SEARCH')

    result1 = invoice_repo.find_all_by_status(:returned)
    assert_equal 23,        result1.size
    assert_equal :returned, result1.first.status

    result2 = invoice_repo.find_all_by_status(:shipped)
    assert_equal 119,      result2.size
    assert_equal :shipped, result2.last.status
  end

  def test_it_can_find_all_instances_of_invoices_by_merchant_id
    assert_equal [], invoice_repo.find_all_by_merchant_id(0)

    result1 = invoice_repo.find_all_by_merchant_id(12336163)
    assert_equal 2, result1.size
    assert(result1.all? { |invoice| invoice.merchant_id == (12336163) })

    result2 = invoice_repo.find_all_by_merchant_id(12336113)
    assert_equal 2, result2.size
    assert(result2.all? { |invoice| invoice.merchant_id == (12336113) })
  end

  def test_it_can_find_all_instances_of_invoices_by_customer_idxw
    assert_equal [], invoice_repo.find_all_by_customer_id(00)

    result1 = invoice_repo.find_all_by_customer_id(5)
    assert_equal 8, result1.size
    assert(result1.all? { |invoice| invoice.customer_id == 5 })

    result2 = invoice_repo.find_all_by_customer_id(2)
    assert_equal 4, result2.size
    assert(result2.all? { |invoice| invoice.customer_id == 2 })
  end

  def test_it_can_delete_invoice_instance_by_id
    result = invoice_repo.find_by_id(5)
    assert_equal :pending, result.status

    invoice_repo.delete(5)

    assert_nil invoice_repo.find_by_id(5)
  end

  def test_can_search_by_invoice_id_and_update_attributes
    result1 = invoice_repo.find_by_id(5)
    assert_equal :pending, result1.status

    invoice_repo.update(5, status: 'delivered')

    result2 = invoice_repo.find_by_id(5)
    assert_equal :delivered, result2.status

    invoice_repo.update(5, status: 'returned')

    result3 = invoice_repo.find_by_id(5)
    assert_equal :returned, result3.status
  end

  def test_can_create_new_invoice_instance_with_given_attributes
    assert_nil invoice_repo.find_by_id(201)

    invoice_repo.create(
      customer_id: 10,
      merchant_id: 12336299,
      status:      :pending
    )

    result1 = invoice_repo.find_by_id(201)
    assert_equal :pending, result1.status
    assert_equal 201,      result1.id
    assert_equal 10,       result1.customer_id
    assert_equal 12336299, result1.merchant_id
  end

  def test_can_inspect_number_of_self_instances
    assert_equal '#<InvoiceRepository 200 rows>', invoice_repo.inspect
  end
end
