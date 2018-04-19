require './test/test_helper'
require_relative '../modules/repository'

# :nodoc:
class RepositoryTest < Minitest::Test

  def setup
    engine = SalesEngine.from_csv(
      invoice_items: './fixtures/fixture_invoice_items.csv',
      items: './fixtures/fixture_items.csv',
      invoices: './fixtures/fixture_invoices.csv',
      merchants: './fixtures/fixture_merchants.csv'
    )
    @invoice_items_repo = engine.invoice_items
    @item_repo = engine.items
    @invoices = engine.invoices
    @merchants = engine.merchants
  end

  def test_it_can_find_instance_with_id
    assert_instance_of InvoiceItem, @invoice_items_repo.find_with_id(@invoice_items_repo.repository, 5)
  end

  def test_it_can_find_instance_with_string
    assert_instance_of Item,
    #binding.pry
    @item_repo.find_by_instance_string(@item_repo.repository, 'BONUS PACK included', :description)
  end

  def test_it_can_find_all_instances_by_string
    assert_instance_of Array,
    @item_repo.find_all_with_instance_string(@item_repo.repository, 'BONUS PACK included', :description)
  end

  def test_it_can_find_all_instances_by_status
    assert_instance_of Array,
    @invoices.find_all_with_status(@invoices.repository, :pending)
  end

  def test_it_can_find_all_instances_by_key
    assert_instance_of Array,
    @invoice_items_repo.find_all_with_instance_key(@invoice_items_repo.repository, '7', :quantity)
  end

  def test_it_can_find_all_instances_in_price_range
    assert_instance_of Array,
    @invoice_items_repo.find_all_instances_in_price_range(@invoice_items_repo.repository, (5..8))
  end

  def test_it_can_delete_instance_by_id
    assert_instance_of InvoiceItem, @invoice_items_repo.find_with_id(@invoice_items_repo.repository, 3)
    @invoice_items_repo.delete_instance(@invoice_items_repo.repository, 3)
    assert_nil @invoice_items_repo.find_with_id(@invoice_items_repo.repository, 3)
  end

  def test_it_can_create_a_new_instance
    skip
    result_1 = @merchants.find_with_id(@merchants.repository, 102)
    assert_nil result_1
    attributes = {name: 'Turing Store'}
    @merchants.create_new_instance(@merchants.repository, attributes, Merchant)
    #binding.pry
    result_2 = @merchants.find_with_id(@merchants.repository, 102)
    assert_equal Merchant, result_2.class
  end

  def test_it_can_assign_time
    attributes = {created_at: '0', updated_at: '0'}
    @invoice_items_repo.assign_time(attributes)
    assert_equal attributes, ({created_at: Time.now.to_s, updated_at: Time.now.to_s})
  end

  def test_it_can_change_attribute
    
  end
end
