require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_items_repo
  def setup
    engine = SalesEngine.from_csv(
      invoice_items: './fixtures/fixture_invoice_items.csv'
    )
    @invoice_items_repo = engine.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, invoice_items_repo
  end

  def test_it_has_all_invoice_items_in_array_and_all_invoice_items_are_invoice_items
    assert_instance_of Array, invoice_items_repo.all
    assert_equal 100, invoice_items_repo.all.count
    assert(invoice_items_repo.all.all? { |invoice_item| invoice_item.is_a?(InvoiceItem) })
  end

  def test_it_can_find_specified_invoice_items_by_id
    result1 = invoice_items_repo.find_by_id(28)
    assert_equal 28, result1.id

    result2 = invoice_items_repo.find_by_id(44)
    assert_equal 44, result2.id

    result3 = invoice_items_repo.find_by_id(0)
    assert_nil result3
  end

  def test_it_can_find_all_instances_of_invoice_items_by_item_id
    assert_equal [], invoice_items_repo.find_all_by_item_id(0)

    result1 = invoice_items_repo.find_all_by_item_id(263547424)
    assert_equal 4, result1.size
    assert(result1.all? { |invoice_item| invoice_item.item_id == 263547424 })

    result2 = invoice_items_repo.find_all_by_item_id(263554000)
    assert_equal 3, result2.size
    assert(result2.all? { |invoice_item| invoice_item.item_id == 263554000 })
  end

  def test_it_can_find_all_instances_of_invoice_items_by_invoice_id
    assert_equal [], invoice_items_repo.find_all_by_invoice_id(0)

    result1 = invoice_items_repo.find_all_by_invoice_id(3)
    assert_equal 8, result1.size
    assert(result1.all? { |invoice_item| invoice_item.invoice_id == 3 })

    result2 = invoice_items_repo.find_all_by_invoice_id(10)
    assert_equal 5, result2.size
    assert(result2.all? { |invoice_item| invoice_item.invoice_id == 10 })
  end

  def test_it_can_delete_invoice_item_instance_by_id
    result = invoice_items_repo.find_by_id(14)
    assert_equal 42.64, result.unit_price_to_dollars

    invoice_items_repo.delete(14)

    assert_nil invoice_items_repo.find_by_id(14)
  end

  def test_can_search_by_invoice_items_id_and_update_attributes
    result1 = invoice_items_repo.find_by_id(5)
    assert_equal 7,      result1.quantity
    assert_equal 791.40, result1.unit_price_to_dollars
    assert_equal '2012-03-27 14:54:09 UTC', result1.updated_at.to_s

    invoice_items_repo.update(5, quantity: 20,
                                 unit_price: 500.00)

    result2 = invoice_items_repo.find_by_id(5)
    assert_equal 20,     result2.quantity
    assert_equal 500.00, result2.unit_price_to_dollars
    assert_equal Time.now.to_s, result1.updated_at.to_s
  end

  def test_can_create_new_invoice_items_instance_with_given_attributes
    assert_nil invoice_items_repo.find_by_id(101)

    invoice_items_repo.create(invoice_id: 10,
                              item_id: 263526970,
                              unit_price: 1700,
                              quantity: 32)

    result1 = invoice_items_repo.find_by_id(101)
    assert_equal 32,        result1.quantity
    assert_equal 10,        result1.invoice_id
    assert_equal 263526970, result1.item_id
  end

  def test_can_inspect_number_of_self_instances
    assert_equal '#<InvoiceItemRepository 100 rows>', invoice_items_repo.inspect
  end
end
