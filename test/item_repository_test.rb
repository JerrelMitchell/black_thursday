require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo
  def setup
    engine = SalesEngine.from_csv(
      items:     './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv',
      invoices:  './fixtures/fixture_invoices.csv'
    )
    @item_repo = engine.items
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
    result1 = item_repo.find_by_id(263395237)
    assert_equal 263395237, result1.id

    result2 = item_repo.find_by_id(263405861)
    assert_equal 263405861, result2.id

    result3 = item_repo.find_by_id(00000)
    assert_nil result3
  end

  def test_it_can_find_specified_item_by_case_insensitive_name
    result1 = item_repo.find_by_name('510+ REALPUSH ICON SET')
    assert_equal '510+ RealPush Icon Set', result1.name

    result2 = item_repo.find_by_name('510+ realpush icon set')
    assert_equal '510+ RealPush Icon Set', result2.name

    assert_nil item_repo.find_by_name('REALPUSH!!!???!')
  end

  def test_it_can_delete_item_instance_by_id
    result1  = item_repo.find_by_id(263406189)
    expected = 'Small turquoise stoneware pot'
    assert_equal expected, result1.name

    item_repo.delete(263406189)

    assert_nil item_repo.find_by_id(263406189)
  end

  def test_can_create_new_item_instance_with_given_attributes
    assert_nil item_repo.find_by_id(263409042)

    item_repo.create(name: 'Awesome Tissue Box',
                     description: "It's a tissue box that's awesome!",
                     unit_price: '9900')

    result1 = item_repo.find_by_id(263409042)
    assert_equal 'Awesome Tissue Box', result1.name
    assert_equal 263409042,            result1.id
    assert_equal 99.00,                result1.unit_price_to_dollars
  end

  def test_can_search_by_id_and_update_attributes
    result1 = item_repo.find_by_name('Harris - Cinnamon Buns')

    assert_equal 'Harris - Cinnamon Buns', result1.name
    assert_equal 7.95,                     result1.unit_price_to_dollars

    item_repo.update(263409041, name: 'Sinnamon Bunz',
                                description: 'Like Cinnamon, but more fun!',
                                unit_price: '7')

    result2 = item_repo.find_by_name('Sinnamon Bunz')
    assert_equal 'Sinnamon Bunz',                result2.name
    assert_equal 'Like Cinnamon, but more fun!', result2.description
    assert_equal 7.00,                           result2.unit_price_to_dollars
  end

  def test_it_can_find_all_instances_of_items_by_price
    assert_equal [], item_repo.find_all_by_price(8.75)

    price1 = 150.00
    result1 = item_repo.find_all_by_price(price1)
    assert_equal 4, result1.size
    assert(result1.all? { |item| item.unit_price == price1 })

    price2 = 12.00
    result2 = item_repo.find_all_by_price(12.00)
    assert_equal 2, result2.size
    assert(result2.all? { |item| item.unit_price == price2 })
  end

  def test_it_can_find_all_instances_of_items_by_merchant_id
    assert_equal [], item_repo.find_all_by_merchant_id(00000)

    result1 = item_repo.find_all_by_merchant_id(12334185)
    assert_equal 3, result1.size
    assert(result1.all? { |item| item.merchant_id.eql?(12334185) })
    assert_equal 'Glitter scrabble frames',     result1.first.name
    assert_equal 'Free standing Woden letters', result1.last.name

    result2 = item_repo.find_all_by_merchant_id(12334123)
    assert_equal 10, result2.size
    assert(result2.all? { |item| item.merchant_id.eql?(12334123) })
    assert_equal 'Adidas Breitner Super Fußballschuh', result2.first.name
    assert_equal 'Adidas Penarol Cup Fußballschuh',    result2.last.name
  end

  def  test_it_can_find_all_instances_of_items_in_a_price_range
    assert_equal [], item_repo.find_all_by_price_in_range(0..0.1)

    result1 = item_repo.find_all_by_price_in_range(0..5)
    assert_equal 6,     result1.size
    assert_equal 3.99,  result1.first.unit_price_to_dollars
    assert_equal 4.95,  result1.last.unit_price_to_dollars
    assert_equal 'Small wonky stoneware pot', result1[1].name
  end

  def test_it_can_find_all_instances_of_an_item_included_in_a_description
    expected1 =
      'Handgerfertigete Topflappen in Form einer Eule. '\
'Die Topflappen wurden aus Wolle gehäkelt. '\
"Als Augen wurden Knöpfe verwendet.\n\n"\
"Der Verkauf erfolgt paarweise.\n\nHandmade in Germany\n
Masse: Länge 22,5cm; Breite (breiteste Stelle) 17 cm"
    expected2 =
      "&quot;Harris&quot; - Cinnamon Buns Scent.\n"\
"Hand Wicked and Hand Poured, Small Batch Candles.\n"\
"Natural Soy Wax.\nNatural Wick.\nReusable Tin Container.\n"\
"Available in two sizes: 8 oz or 4 oz.\n8 oz. Burn Time: 30-32 hours\n"\
"4 oz. Burn Time: 15 hours\n\n"\
'Due to the handmade nature of our products, there may be a slight variation '\
'in the coloring or burn time of your candle. We strive to make all of our '\
'candles with highest quality materials and utmost care.'
    result1 = item_repo.find_all_with_description('handmade')
    assert_equal 16,        result1.size
    assert_equal expected1, result1.first.description
    assert_equal expected2, result1.last.description
  end

  def test_it_can_inspect_how_many_rows_of_instances_are_within_itself
    assert_equal '#<ItemRepository 94 rows>', item_repo.inspect
  end
end
