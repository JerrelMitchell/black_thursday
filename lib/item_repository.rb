# frozen_string_literal true
require 'csv'
require_relative 'item'
require 'bigdecimal'
# robocomment
class ItemRepository
  attr_reader :items

  def initialize(filepath)
    @items = []
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
