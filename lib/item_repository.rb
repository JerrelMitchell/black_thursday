require_relative 'file_loader'
require_relative 'repository'
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
    find_all_attributes(@items)
  end

  def find_by_id(id)
    find_by_attribute_id(@items, id)
  end

  def find_by_name(name)
    find_by_attribute_name(@items, name)
  end

  def find_all_with_description(description)
    find_all_with_attribute_description(@items, description)
  end

  def find_all_by_price(price)
    find_all_by_attribute_price(@items, price)
  end

  def find_all_by_price_in_range(price_range)
    find_all_attributes_in_price_range(@items, price_range)
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.attributes[:merchant_id].eql?(merchant_id)
    end
  end

  def delete(id)
    delete_attribute(@items, id)
  end

  def create(attributes)
    highest_item_id_instance = @items.max_by do |item|
      item.attributes[:id]
    end
    new_item_id = (highest_item_id_instance.attributes[:id] + 1)
    attributes[:id]         = new_item_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @items << Item.new(attributes, self)
  end

  def update(id, attributes)
    current_instance = find_by_id(id)
    change_all_requested_attributes(current_instance, attributes)
  end

  def change_all_requested_attributes(current_instance, attributes)
    attributes.each do |key, value|
      next if (attributes.keys & @unchangeable_keys).any?
      change_attribute(current_instance, key, value)
    end
  end

  def change_attribute(item, key, value)
    item.attributes[key]         = value if item.attributes.keys.include?(key)
    item.attributes[:updated_at] = Time.now
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
