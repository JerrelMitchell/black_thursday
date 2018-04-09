# frozen_string_literal: true

require './test/test_helper'
require 'bigdecimal'
require_relative '../lib/item'

# :nodoc:
class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new(
      id: '5',
      name: 'Pencil',
      description: 'Can be used to write things',
      unit_price: BigDecimal.new(10.99, 4),
      created_at: '2016-01-11 17:42:32 UTC',
      updated_at: '2016-01-11 17:42:32 UTC',
      merchant_id: '7'
    )
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_it_has_attributes
    assert_equal 5, item.id
    assert_equal 7, item.merchant_id
    assert_equal 10.99, item.unit_price
    assert_equal 'Pencil', item.name
    assert_equal 'Can be used to write things', item.description
  end

  def test_it_can_show_times_when_created_and_updated
    creation_date = '2016-01-11 17:42:32 UTC'
    updated_date = '2016-01-11 17:42:32 UTC'
    assert_equal creation_date, item.created_at
    assert_equal updated_date, item.updated_at
  end

  def test_its_price_in_dollar_amount_is_formatted_as_a_float
    assert_instance_of Float, item.unit_price_to_dollars
    assert_equal 10.99, item.unit_price_to_dollars
  end
end
