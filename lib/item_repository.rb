require 'csv'
require_relative 'item'

# robocomment
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
end
