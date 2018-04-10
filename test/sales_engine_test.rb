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
    
  end

  def test_it_has_merchants
  end
end
