require './test/test_helper'
require_relative '../lib/customer'

# :nodoc:
class CustomerTest < Minitest::Test
  def setup
    @customer = Customer.new({
                               id: 6,
                               first_name: 'Joan',
                               last_name: 'Clarke',
                               created_at: '2017-12-15 17:42:32 UTC',
                               updated_at: '2017-12-15 17:42:32 UTC'
                             },
                             'parent')
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 6, @customer.id
    assert_equal 'Joan', @customer.first_name
    assert_equal 'Clarke', @customer.last_name
  end

  def test_it_can_show_times_when_created_and_updated
    creation_date = '2017-12-15 17:42:32 UTC'
    updated_date = '2017-12-15 17:42:32 UTC'
    assert_equal creation_date, @customer.created_at.to_s
    assert_equal updated_date, @customer.updated_at.to_s
  end
end
