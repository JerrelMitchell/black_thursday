require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo
  def setup
    @engine_csvs = SalesEngine.from_csv(
      items: './data/small_items.csv',
      merchants: './data/small_merchants.csv'
    )
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
    result1 = merchant_repo.find_by_id(12334135)
    assert_equal 12334135, result1.id

    result2 = merchant_repo.find_by_id(12334105)
    assert_equal 12334105, result2.id

    result3 = merchant_repo.find_by_id(000000)
    assert_nil result3
  end

  def test_it_can_find_specified_merchant_by_name
    result1 = merchant_repo.find_by_name('BowlsByChris')
    assert_equal 'BowlsByChris', result1.name

    result2 = merchant_repo.find_by_name('bowlsbychris')
    assert_equal 'BowlsByChris', result2.name

    result3 = merchant_repo.find_by_name('BOWLSBYCHRIS')
    assert_equal 'BowlsByChris', result3.name

    assert_nil merchant_repo.find_by_name('bowls?bychr!s')
  end

  def test_it_can_find_all_instances_of_a_name_or_partial_name
    result1 = merchant_repo.find_all_by_name('ess')
    assert_equal 3, result1.size
    expected1 = %w[GoldenRayPress Princessfrankknits WellnessNeelsen]
    assert_equal expected1.first, result1.first.name
    assert_equal expected1.last, result1.last.name

    result2 = merchant_repo.find_all_by_name('art')
    assert_equal 3, result2.size
    expected2 = %w[Candisart SassyStrangeArt esellermart]
    assert_equal expected2.first, result2.first.name
    assert_equal expected2.last, result2.last.name

    assert_equal [], merchant_repo.find_all_by_name('nil example')
  end

  def test_it_can_delete_merchant_by_id
    result = merchant_repo.find_by_id(12334105)
    assert_equal 12334105, result.id

    merchant_repo.delete(12334105)
    assert_nil merchant_repo.find_by_id(12334105)
  end

  def test_can_create_new_merchant_instances_with_given_attributes
    result1 = merchant_repo.find_by_id(12334265)
    assert_nil result1

    merchant_repo.create(name: 'AtomStore')
    result2 = merchant_repo.find_by_id(12334265)
    assert_equal 12334265, result2.id
    assert_equal 'AtomStore', result2.name

    merchant_repo.create(name: 'FunStore Name!')
    result3 = merchant_repo.find_by_id(12334266)
    assert_equal 12334266, result3.id
    assert_equal 'FunStore Name!', result3.name
  end

  def test_can_search_by_id_and_update_name_attribute
    result1 = merchant_repo.find_by_name('Shopin1901')
    assert_equal 'Shopin1901', result1.name
    assert_equal 12334105, result1.id

    merchant_repo.update(12334105, name: 'Shoppein1799')
    assert_nil merchant_repo.find_by_name('Shopin1901')

    result2 = merchant_repo.find_by_name('Shoppein1799')
    assert_equal 12334105, result2.id
    assert_equal 'Shoppein1799', result2.name
  end

  def test_update_on_unknown_merchant_does_nothing
    assert_nil merchant_repo.find_by_name('Nil Example Shop')
    assert_nil merchant_repo.update(00000, name: 'Nil Example Shop')
  end
end
