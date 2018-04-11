require 'bigdecimal'
require 'time'
# :nodoc:
class Item
  attr_accessor :name, :updated_at, :unit_price, :description, :parent
  attr_reader   :id, :created_at, :merchant_id

  def initialize(item, parent)
    @name        = item[:name]
    @id          = item[:id].to_i
    @description = item[:description]
    @merchant_id = item[:merchant_id].to_i
    @unit_price  = BigDecimal.new(item[:unit_price]) / 100.0
    @created_at  = Time.parse(item[:created_at])
    @updated_at  = Time.parse(item[:updated_at])
    @parent      = parent
  end

  def unit_price_to_dollars
    unit_price.to_f.round(2)
  end
end
