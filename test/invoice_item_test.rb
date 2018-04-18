require './test/test_helper'
require_relative '../lib/invoice_item'

# :nodoc:
class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item
  def setup
    @invoice_item = InvoiceItem.new({
                                      id: '5',
                                      item_id: '1234567890',
                                      invoice_id: '12',
                                      quantity: '7',
                                      unit_price: '1099',
                                      created_at: '2016-01-11 17:42:32 UTC',
                                      updated_at: '2016-01-11 17:42:32 UTC'
                                    },
                                    'parent')
  end

  def test_it_exists
    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_has_attributes
    assert_equal 5, invoice_item.id
    assert_equal 1234567890, invoice_item.item_id
    assert_equal 12, invoice_item.invoice_id
    assert_equal 7, invoice_item.quantity
    assert_equal 10.99, invoice_item.unit_price
  end

  def test_its_price_in_dollar_amount_is_formatted_as_a_float
    assert_instance_of Float, invoice_item.unit_price_to_dollars
    assert_equal 10.99, invoice_item.unit_price_to_dollars
  end

  def test_it_can_show_times_when_created_and_updated
    creation_date = '2016-01-11 17:42:32 UTC'
    updated_date = '2016-01-11 17:42:32 UTC'
    assert_equal creation_date, invoice_item.created_at.to_s
    assert_equal updated_date, invoice_item.updated_at.to_s
  end
end
