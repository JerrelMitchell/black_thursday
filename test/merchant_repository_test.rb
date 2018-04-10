require './test/test_helper'
require_relative '../lib/merchant_repository'

# :nodoc:
class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repo = MerchantRepository.new('./data/small_merchants.csv')
    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_has_all_merchants_in_array_and_all_merchants_are_merchants
    merchant_repo = MerchantRepository.new('./data/small_merchants.csv')

    assert_instance_of Array, merchant_repo.all
    assert_equal 39, merchant_repo.all.count
    assert(merchant_repo.all.all? { |merchant| merchant.is_a?(Merchant) })
  end

  # def test_it_can_create_a_new_merchant_instance
  #   attributes = ''
  #   merchant_repository.create(attributes)
  #   assert_equal [''], merchant_repository.all
  # end
  #
  # def test_it_can_find_specified_merchant_by_id
  #   skip
  #   attributes = ''
  #   merchant_repository.create(attributes)
  #   assert_equal '', merchant_repository.find_by_id(id)
  # end
  #
  # def test_it_can_find_specified_merchant_by_name
  #   skip
  #   attributes = ''
  #   merchant_repository.create(attributes)
  #   assert_equal '', merchant_repository.find_by_name(name)
  # end
  #
  # def test_it_can_find_all_matching_merchants_that_contain_specified_string
  #   skip
  #   attributes = ''
  #   merchant_repository.create(attributes)
  #   assert_equal '', merchant_repository.find_all_by_name(name)
  # end
  #
  # def test_it_can_update_an_established_merchant
  #   skip
  #   attributes = ''
  #   merchant_repository.create(attributes)
  #   merchant_repository.update(id, attributes)
  #   assert_equal '', merchant_repository.find_by_id(id)
  # end
  #
  # def test_it_can_delete_an_established_merchant_from_the_list_by_id
  #   skip
  #   attributes = ''
  #   merchant_repository.create(attributes)
  #   merchant_repository.delete(id)
  #   assert_equal [], merchant_repository.all
  # end
end
