require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class SalesEngineTest < Minitest::Test
  attr_reader :engine
  def setup
    @engine = SalesEngine.from_csv(
      items: './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv'
    )
  end

  def test_has_instances_of_item_and_merchant_repositories
    assert_instance_of ItemRepository, engine.items
    assert_instance_of MerchantRepository, engine.merchants
  end

  def test_it_has_attributes
    assert_equal '510+ RealPush Icon Set', engine.items.all.first.name
    assert_equal 'Shopin1901', engine.merchants.all.first.name
  end

  def test_it_can_collect_merchant_instance_determined_by_matching_merchant_id
    result = engine.collect_merchant_by_id(12334185)
    assert_equal 12334185, result.id
    assert_equal Merchant, result.class
  end
end
