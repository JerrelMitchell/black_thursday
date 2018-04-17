require_relative '../modules/repository'
require_relative '../modules/file_loader'
require_relative 'item'

# :nodoc:
class ItemRepository
  include FileLoader
  include Repository
  attr_reader :items
  def initialize(filepath, parent)
    @items = []
    @parent = parent
    @unchangeable_keys = %I[id item_id created_at]
    load_attributes(filepath, @items, Item)
  end

  def all
    @items
  end

  def find_by_id(id)
    find_with_id(@items, id)
  end

  def find_by_name(name)
    find_by_instance_string(@items, name, :name)
  end

  def find_all_with_description(description)
    find_all_with_instance_string(@items, description, :description)
  end

  def find_all_by_price(price)
    find_all_with_instance_key(@items, price, :unit_price)
  end

  def find_all_by_price_in_range(price_range)
    find_all_instances_in_price_range(@items, price_range)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_with_instance_key(@items, merchant_id, :merchant_id)
  end

  def delete(id)
    delete_instance(@items, id)
  end

  def create(attributes)
    create_new_instance(@items, attributes, Item)
  end

  def update(id, attributes)
    update_instance(id, attributes, @items, @unchangeable_keys)
  end

  def inspect
    inspect_instance(self, @items)
  end
end
