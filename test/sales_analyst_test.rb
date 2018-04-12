require './test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_analyst = SalesEngine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_find_average_items_for_each_merchant
    assert_equal 0, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation_for_average_items_per_merchant
    assert_equal 0, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_average_item_price_for_merchant_returns_for_given_merchant
    assert_equal 0, @sales_analyst.average_item_price_for_merchant(@merchant.id)
    # according to spec harness, this method should be called
    # average_item_price_for_merchant and should return a BigDecimal
  end

  def test_it_returns_average_item_price_for_all_merchants
    assert_equal 0, @sales_analyst.average_average_price_per_merchant
    # according to spec harness, this method should be called
    # average_average_price_per_merchant and should return a BigDecimal
  end

  def test_it_can_find_merchants_with_high_item_count
    assert_equal ['merchant 1', 'merchant 2'], @sales_analyst.merchants_with_high_item_count
    # more than one standard deviation above the average number of products offered
  end

  def test_it_returns_golden_items
    assert_equal ['golden item 1', 'golden item 2'], @sales_analyst.golden_items
    # golden items are two standard deviations above average price
    # this method should return an array
  end
  #
  # let(:sales_analyst) { engine.analyst }
  #
  # it "#average_items_per_merchant returns average items per merchant" do
  #   expected = sales_analyst.average_items_per_merchant
  #
  #   expect(expected).to eq 2.88
  #   expect(expected.class).to eq Float
  # end
  #
  # it "#average_items_per_merchant_standard_deviation returns the standard deviation" do
  #   expected = sales_analyst.average_items_per_merchant_standard_deviation
  #
  #   expect(expected).to eq 3.26
  #   expect(expected.class).to eq Float
  # end
  # it "#merchants_with_high_item_count returns merchants more than one standard deviation above the average number of products offered" do
  #   expected = sales_analyst.merchants_with_high_item_count
  #
  #   expect(expected.length).to eq 52
  #   expect(expected.first.class).to eq Merchant
  # end
  #
  # it "#average_item_price_for_merchant returns the average item price for the given merchant" do
  #   merchant_id = 12334105
  #   expected = sales_analyst.average_item_price_for_merchant(merchant_id)
  #
  #   expect(expected).to eq 16.66
  #   expect(expected.class).to eq BigDecimal
  # end
  #
  # it "#average_average_price_per_merchant returns the average price for all merchants" do
  #   expected = sales_analyst.average_average_price_per_merchant
  #
  #   expect(expected).to eq 350.29
  #   expect(expected.class).to eq BigDecimal
  # end
  #
  # it "#golden_items returns items that are two standard deviations above the average price" do
  #   expected = sales_analyst.golden_items
  #
  #   expect(expected.length).to eq 5
  #   expect(expected.first.class).to eq Item

end
