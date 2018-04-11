require './test/test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

# :nodoc:
class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo
  def setup
    @engine_csvs = SalesEngine.from_csv({
      items: './data/small_items.csv',
      merchants: './data/small_merchants.csv'
    })
    @item_repo = @engine_csvs.items
  end

  def test_it_exists
    assert_instance_of ItemRepository, item_repo
  end

  def test_it_has_all_items_in_array_and_all_items_are_items
    assert_instance_of Array, item_repo.all
    assert_equal 94, item_repo.all.count
    assert(item_repo.all.all? { |item| item.is_a?(Item) })
  end

  def test_it_can_find_specified_item_by_id
    assert_instance_of Item, item_repo.find_by_id(263395237)
    assert_equal 263395237, item_repo.find_by_id(263395237).id
  end

  def test_it_can_find_specified_item_by_name
    assert_instance_of Item, item_repo.find_by_name('510+ RealPush Icon Set')
    assert_equal '510+ RealPush Icon Set', item_repo.find_by_name('510+ REALPUSH ICON SET').name
    assert_equal '510+ RealPush Icon Set', item_repo.find_by_name('510+ realpush icon set').name
    assert_nil item_repo.find_by_name('REALPUSH!!!???!')
  end

  def test_it_can_delete_item_instance_by_id
    assert_instance_of Item, item_repo.find_by_id(263395237)
    item_repo.delete(263395237)
    assert_nil item_repo.find_by_id(263395237)
  end

  def test_can_create_new_item_instance_with_given_attributes
    assert_nil item_repo.find_by_id(263409042)
    item_repo.create('Awesome Tissue Box', "It's a tissue box that's awesome!", '9900')
    assert_instance_of Item, item_repo.find_by_id(263409042)
    assert_equal 263409042, item_repo.find_by_id(263409042).id
    assert_equal 'Awesome Tissue Box', item_repo.find_by_name('Awesome Tissue Box').name
    assert_equal 9900, item_repo.find_by_name('Awesome Tissue Box').unit_price
  end

  def test_can_search_by_id_and_update_name_attribute
    assert_equal 'Harris - Cinnamon Buns', item_repo.find_by_name('Harris - Cinnamon Buns').name
    item_repo.update(263409041, 'Sinnamon Bunz', 'Like Cinnamon, but more fun!', '700')
    assert_equal 'Sinnamon Bunz', item_repo.find_by_name('Sinnamon Bunz').name
    assert_equal 'Like Cinnamon, but more fun!', item_repo.find_by_name('Sinnamon Bunz').description
  end

  def test_it_can_find_all_instances_of_items_by_price
    expected = 1200
    assert_equal [], item_repo.find_all_by_price('875')
    assert_instance_of Item, item_repo.find_all_by_price('1200').first
    assert_equal 2, item_repo.find_all_by_price('1200').size
    assert_equal expected, item_repo.find_all_by_price('1200').first.unit_price_to_dollars
    assert_equal expected, item_repo.find_all_by_price('1200').last.unit_price_to_dollars
  end

  def test_it_can_find_all_instances_of_items_by_merchant_id
    expected = 12334185
    assert_equal [], item_repo.find_all_by_merchant_id(00000)
    assert_instance_of Item, item_repo.find_all_by_merchant_id(12334185).first
    assert_equal 3, item_repo.find_all_by_merchant_id(12334185).size
    assert_equal expected, item_repo.find_all_by_merchant_id(12334185).first.merchant_id
    assert_equal expected, item_repo.find_all_by_merchant_id(12334185).last.merchant_id
  end

  def  test_it_can_find_all_instances_of_items_in_a_price_range
    assert_equal [], item_repo.find_all_by_price_in_range('0'..'1')
    assert_instance_of Item, item_repo.find_all_by_price_in_range(0..500).first
    assert_equal 6, item_repo.find_all_by_price_in_range(0..500).size
    assert_equal 399, item_repo.find_all_by_price_in_range(0..500).first.unit_price_to_dollars
    assert_equal 495, item_repo.find_all_by_price_in_range(0..500).last.unit_price_to_dollars
  end

  def test_it_can_find_all_instances_of_an_item_included_in_a_description
    expected1 = %(Handgerfertigete Topflappen in Form einer Eule. Die Topflappen wurden aus Wolle gehäkelt. Als Augen wurden Knöpfe verwendet.

Der Verkauf erfolgt paarweise.

Handmade in Germany

Masse: Länge 22,5cm; Breite (breiteste Stelle) 17 cm)
    expected2 = %(&quot;Harris&quot; - Cinnamon Buns Scent.
Hand Wicked and Hand Poured, Small Batch Candles.
Natural Soy Wax.
Natural Wick.
Reusable Tin Container.
Available in two sizes: 8 oz or 4 oz.
8 oz. Burn Time: 30-32 hours
4 oz. Burn Time: 15 hours

Due to the handmade nature of our products, there may be a slight variation in the coloring or burn time of your candle. We strive to make all of our candles with highest quality materials and utmost care.)
    assert_instance_of Item, item_repo.find_all_by_description('handmade').first
    assert_equal 16, item_repo.find_all_by_description('handmade').size
    assert_equal expected1, item_repo.find_all_by_description('handmade').first.description
    assert_equal expected2, item_repo.find_all_by_description('handmade').last.description
  end
end
