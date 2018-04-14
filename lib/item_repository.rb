require 'csv'
require 'time'
require 'bigdecimal'
require_relative 'item'
require_relative 'repository'

# :nodoc:
class ItemRepository
  include Repository
  attr_reader :items
  def initialize(filepath, parent)
    @items = []
    @parent = parent
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row, self)
    end
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
      item.merchant_id.eql?(merchant_id)
    end
  end

  def delete(id)
    delete_attribute(@item, id)
  end

  def create(attributes)
    highest_item = @items.max_by(&:id)
    new_item_id = (highest_item.id + 1)
    attributes[:id] = new_item_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @items << Item.new(attributes, self)
  end

  def update(id, attributes)
    current = find_by_id(id)
    unchanging_attributes = %i[id created_at merchant_id]
    assign_attributes(current, attributes, unchanging_attributes)
  end

  def assign_attributes(current_item, attributes, unchanging_attributes)
    attributes.each do
      next if (attributes.keys & unchanging_attributes).any?
      # current_item.name      = attributes[:name]
      current_item.description = attributes[:description]
      current_item.unit_price  = attributes[:unit_price]
      current_item.updated_at  = Time.now
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
