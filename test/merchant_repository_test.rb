# frozen_string_literal: true

require './test/test_helper'
require_relative '../lib/merchant_repository'

# :nodoc:
class MerchantRepositoryTest < Minitest::Test

  def test_it_has_all_merchants
    mr = MerchantRepository.new('./data/small_merchants.csv')

    assert_instance_of Array, mr.all
    assert_equal 39, mr.all.count
    assert mr.all.all? {|merchant| merchant.is_a?(Merchant)}
  end

  def test_it_exists
    mr = MerchantRepository.new('./data/small_merchants.csv')
    assert_instance_of MerchantRepository, mr
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
