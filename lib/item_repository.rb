require 'csv'
require 'time'
require 'bigdecimal'
require_relative 'item'

# :nodoc:
class ItemRepository
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
    @items
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

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price.eql?(price)
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
