require './test/test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv({
      items: './data/small_items.csv',
      merchants: './data/small_merchants.csv'
    })
  end

  def test_it_has_child_instances
    assert_instance_of ItemRepository, sales_engine[:items]
    assert_instance_of MerchantRepository, sales_engine.merchants
  end
end
