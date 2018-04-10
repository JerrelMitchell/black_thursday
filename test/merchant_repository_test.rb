require './test/test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

# :nodoc:
class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo
  def setup
    @engine_csvs = SalesEngine.from_csv({
      items: './data/small_items.csv',
      merchants: './data/small_merchants.csv'
    })
    @merchant_repo = @engine_csvs.merchants
  end

  def test_it_exists
    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_has_all_merchants_in_array_and_all_merchants_are_merchants
    assert_instance_of Array, merchant_repo.all
    assert_equal 39, merchant_repo.all.count
    assert(merchant_repo.all.all? { |merchant| merchant.is_a?(Merchant) })
  end

  def test_it_can_find_specified_merchant_by_id
    assert_instance_of Merchant, merchant_repo.find_by_id(12334135)
    assert_equal 12334135, merchant_repo.find_by_id(12334135).id
  end

  def test_it_can_find_specified_merchant_by_name
    assert_instance_of Merchant, merchant_repo.find_by_name('BowlsByChris')
    assert_equal 'BowlsByChris', merchant_repo.find_by_name('bowlsbychris').name
    assert_equal 'BowlsByChris', merchant_repo.find_by_name('BOWLSBYCHRIS').name
    assert_nil merchant_repo.find_by_name('bowls!bychr!s')
  end

  def test_it_can_find_all_instances_of_a_name
    assert_instance_of Array, merchant_repo.find_all_by_name('ess')
    expected = ["GoldenRayPress", "Princessfrankknits", "WellnessNeelsen"]
    assert_equal expected, merchant_repo.find_all_by_name('ess')
    assert_equal expected, merchant_repo.find_all_by_name('ESS')
    assert_equal [], merchant_repo.find_all_by_name('!!!')
  end

  def test_it_can_delete_merchant_by_id
    assert_instance_of Merchant, merchant_repo.find_by_id(id)
  end

end
