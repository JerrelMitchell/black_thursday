require './test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'

# :nodoc:
class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repo
  def setup
    engine = SalesEngine.from_csv(
      items:     './fixtures/fixture_items.csv',
      merchants: './fixtures/fixture_merchants.csv',
      invoices:  './fixtures/fixture_invoices.csv'
    )
    @invoice_repo = engine.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, invoice_repo
  end

  def test_it_has_all_invoices_in_array_and_all_invoices_are_invoices
    skip
    assert_instance_of Array, invoice_repo.all
    assert_equal 94, invoice_repo.all.count
    assert(invoice_repo.all.all? { |invoice| invoice.is_a?(Invoice) })
  end

  def test_it_can_find_specified_invoice_by_id
    skip
    result1 = invoice_repo.find_by_id(263395237)
    assert_equal 263395237, result1.id

    result2 = invoice_repo.find_by_id(263405861)
    assert_equal 263405861, result2.id

    result3 = invoice_repo.find_by_id(00000)
    assert_nil result3
  end

  def test_it_can_find_specified_invoice_by_case_insensitive_name
    skip
    result1 = invoice_repo.find_by_name('510+ REALPUSH ICON SET')
    assert_equal '510+ RealPush Icon Set', result1.name

    result2 = invoice_repo.find_by_name('510+ realpush icon set')
    assert_equal '510+ RealPush Icon Set', result2.name

    assert_nil invoice_repo.find_by_name('REALPUSH!!!???!')
  end

  def test_it_can_delete_invoice_instance_by_id
    skip
    result1  = invoice_repo.find_by_id(263406189)
    expected = 'Small turquoise stoneware pot'
    assert_equal expected, result1.name

    invoice_repo.delete(263406189)

    assert_nil invoice_repo.find_by_id(263406189)
  end

  def test_can_create_new_invoice_instance_with_given_attributes
    skip
    assert_nil invoice_repo.find_by_id(263409042)

    invoice_repo.create(name: 'Awesome Tissue Box',
                     description: "It's a tissue box that's awesome!",
                     unit_price: '9900')

    result1 = invoice_repo.find_by_id(263409042)
    assert_equal 'Awesome Tissue Box', result1.name
    assert_equal 263409042,            result1.id
    assert_equal 99.00,                result1.unit_price_to_dollars
  end

  def test_can_search_by_id_and_update_attributes
    skip
    result1 = invoice_repo.find_by_name('Harris - Cinnamon Buns')

    assert_equal 'Harris - Cinnamon Buns', result1.name
    assert_equal 7.95,                     result1.unit_price_to_dollars

    invoice_repo.update(263409041, name: 'Sinnamon Bunz',
                                description: 'Like Cinnamon, but more fun!',
                                unit_price: '7')

    result2 = invoice_repo.find_by_name('Sinnamon Bunz')
    assert_equal 'Sinnamon Bunz',                result2.name
    assert_equal 'Like Cinnamon, but more fun!', result2.description
    assert_equal 7.00,                           result2.unit_price_to_dollars
  end

  def test_it_can_find_all_instances_of_invoices_by_price
    skip
    assert_equal [], invoice_repo.find_all_by_price(8.75)

    result1 = invoice_repo.find_all_by_price(150)
    assert_equal 4,      result1.size
    assert_equal 150.00, result1.first.unit_price_to_dollars

    result2 = invoice_repo.find_all_by_price(12.00)
    assert_equal 2,     result2.size
    assert_equal 12.00, result2.last.unit_price_to_dollars
  end

  def test_it_can_find_all_instances_of_invoices_by_merchant_id
    skip
    assert_equal [], invoice_repo.find_all_by_merchant_id(00000)

    result1 = invoice_repo.find_all_by_merchant_id(12334185)
    assert_equal 3,        result1.size
    assert_equal 12334185, result1.first.merchant_id
    assert_equal 12334185, result1.last.merchant_id
    assert_equal 'Glitter scrabble frames',     result1.first.name
    assert_equal 'Free standing Woden letters', result1.last.name

    result2 = invoice_repo.find_all_by_merchant_id(12334123)
    assert_equal 10,       result2.size
    assert_equal 12334123, result2.first.merchant_id
    assert_equal 12334123, result2.last.merchant_id
    assert_equal 'Adidas Breitner Super Fußballschuh', result2.first.name
    assert_equal 'Adidas Penarol Cup Fußballschuh',    result2.last.name
  end

  def test_it_can_find_all_instances_of_invoices_in_a_price_range
    skip
    assert_equal [], invoice_repo.find_all_by_price_in_range(0..0.1)

    result1 = invoice_repo.find_all_by_price_in_range(0..5)
    assert_equal 6,     result1.size
    assert_equal 3.99,  result1.first.unit_price_to_dollars
    assert_equal 4.95,  result1.last.unit_price_to_dollars
    assert_equal 'Small wonky stoneware pot', result1[1].name
  end

  def test_it_can_inspect_how_many_rows_of_instances_are_within_itself
    skip
    assert_equal '#<InvoiceRepository 94 rows>', invoice_repo.inspect
  end
end
