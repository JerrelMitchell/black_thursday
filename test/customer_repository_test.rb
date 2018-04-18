require './test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def setup
    engine = SalesEngine.from_csv(
      customers: './fixtures/fixture_customers.csv'
    )
    @customer_repo = engine.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repo
  end

  def test_it_can_find_all_by_first_name
    assert_instance_of Array, @customer_repo.all
    assert_equal 100, @customer_repo.all.count
    assert(@customer_repo.all.all? { |customer| customer.is_a?(Customer) })
  end

  def test_it_can_find_specified_customers_by_id
    result1 = @customer_repo.find_by_id(12)
    assert_equal 12, result1.id
    assert_equal 'Ilene', result1.first_name

    result2 = @customer_repo.find_by_id(44)
    assert_equal 44, result2.id
    assert_equal 'Upton', result2.last_name

    assert_nil @customer_repo.find_by_id(0)
  end

  def test_it_can_find_all_customers_that_share_first_name
    result1 = @customer_repo.find_all_by_first_name('Felipe')
    assert_equal Customer, result1.first.class
    assert_equal 3,        result1.size
    assert_equal 'Felipe', result1.first.first_name
    assert_equal 'Felipe', result1.last.first_name
    assert_equal 'Luettgen', result1.first.last_name
    assert_equal 'Wilkinson', result1.last.last_name
  end

  def test_it_can_find_all_customers_that_share_last_name
    result2 = @customer_repo.find_all_by_last_name('Ross')
    assert_equal Customer, result2.first.class
    assert_equal 4,        result2.size
    assert_equal 'Leanne', result2.first.first_name
    assert_equal 'Maryam', result2.last.first_name
    assert_equal 'Ross', result2.first.last_name
    assert_equal 'Ross', result2.last.last_name
  end

  def test_it_can_delete_customer_instance_by_id
    result = @customer_repo.find_by_id(14)
    assert_equal 'Casimer', result.first_name

    @customer_repo.delete(14)

    assert_nil @customer_repo.find_by_id(14)
  end

  def test_it_can_create_a_new_customer_with_given_attributes
    assert_nil @customer_repo.find_by_id(101)

    @customer_repo.create(first_name: 'Bob',
                          last_name: 'Ross')

    result = @customer_repo.find_by_id(101)
    assert_equal 101, result.id
    assert_equal 'Bob', result.first_name
    assert_equal 'Ross', result.last_name
    assert_equal Time.now.to_s, result.created_at.to_s
  end

  def test_it_can_update_customer
    result1 = @customer_repo.find_by_id(1)
    assert_equal 'Joey', result1.first_name
    assert_equal 'Ondricka', result1.last_name
    assert_equal '2012-03-27 14:54:09 UTC', result1.updated_at.to_s

    @customer_repo.update(1, first_name: 'Joseph',
                             last_name: 'Ondrick')

    result2 = @customer_repo.find_by_id(1)
    assert_equal 'Joseph', result2.first_name
    assert_equal 'Ondrick', result2.last_name
    assert_equal Time.now.to_s, result2.updated_at.to_s
  end

  def test_can_inspect_number_of_self_instances
    assert_equal '#<CustomerRepository 100 rows>', @customer_repo.inspect
  end
end
