require './test/test_helper'
require_relative '../lib/item_repository'

# :nodoc:
class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repo = ItemRepository.new('./data/small_items.csv')
    assert_instance_of ItemRepository, item_repo
  end

  def test_it_has_all_items_in_array_and_all_items_are_items
    item_repo = ItemRepository.new('./data/small_items.csv')

    assert_instance_of Array, item_repo.all
    assert_equal 94, item_repo.all.count
    assert(item_repo.all.all? { |item| item.is_a?(Item) })
  end


end
