require './test/test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :invoice
  def setup
    @invoice = Invoice.new({
                             id:          '9',
                             customer_id: '6',
                             merchant_id: '2',
                             status:      'pending',
                             created_at:  '2017-12-13 17:42:32 UTC',
                             updated_at:  '2017-12-13 17:42:32 UTC'
                           },
                           'parent')
  end

  def test_it_exists
    assert_instance_of Invoice, invoice
  end

  def test_it_has_attributes
    assert_equal 9,         invoice.id
    assert_equal 6,         invoice.customer_id
    assert_equal 2,         invoice.merchant_id
    assert_equal 'pending', invoice.status
  end

  def test_it_can_show_times_when_created_and_updated
    creation_date = '2017-12-13 17:42:32 UTC'
    updated_date  = '2017-12-13 17:42:32 UTC'
    assert_equal creation_date, invoice.created_at.to_s
    assert_equal updated_date,  invoice.updated_at.to_s
  end
end
