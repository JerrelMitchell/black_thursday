require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesEngineTest < Minitest::Test
  def setup
    @engine_csvs = SalesEngine.from_csv({
      items: './data/small_items.csv',
      merchants: './data/small_merchants.csv'
    })
  end

  def test_it_has_items
    assert_equal '510+ RealPush Icon Set', @engine_csvs.items.all.first.name
  end

  def test_it_has_merchants
    assert_equal 'Shopin1901', @engine_csvs.merchants.all.first.name
  end

  def test_has_instances_of_item_repository
    assert_instance_of ItemRepository, @engine_csvs.items
  end

  def test_has_instances_of_merchant_repository
    assert_instance_of MerchantRepository, @engine_csvs.merchants
  end

end
