require 'csv'
require 'bigdecimal'
require_relative 'item'

class ItemRepository
  attr_reader :items
  def initialize(filepath, parent)
    @items = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_by_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars.to_i.eql?(price.to_i)
    end
  end

  def find_all_by_price_in_range(price_range)
    @items.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id.eql?(merchant_id)
    end
  end

  def delete(id)
    item_instance = find_by_id(id)
    @items.delete(item_instance)
  end

  def create(name, description, unit_price)
    highest_item = @items.max_by do |item|
      item.id
    end
    new_item_id = (highest_item.id + 1)
    new_item_attributes = {
      name: name,
      id: new_item_id,
      description: description,
      unit_price: unit_price
    }
    @items << Item.new(new_item_attributes)
  end

  def update(id, new_name, new_description, new_price)
    current = find_by_id(id)
    current.name = new_name
    current.description = new_description
    current.unit_price = new_price
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
