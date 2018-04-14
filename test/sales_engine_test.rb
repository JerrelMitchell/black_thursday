require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesEngineTest < Minitest::Test
  attr_reader :engine
  def setup
    @engine = SalesEngine.from_csv(
      items: './data/small_items.csv',
      merchants: './data/small_merchants.csv'
    )
  end

  def test_it_has_items
    assert_equal '510+ RealPush Icon Set', engine.items.all.first.name
  end

  def test_it_has_merchants
    assert_equal 'Shopin1901', engine.merchants.all.first.name
  end

  def test_has_instances_of_item_repository
    assert_instance_of ItemRepository, engine.items
  end

  def test_has_instances_of_merchant_repository
    assert_instance_of MerchantRepository, engine.merchants
  end
end
