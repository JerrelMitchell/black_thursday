require 'bigdecimal'
require 'time'

# Stores instance attributes generated from SalesEngine.
class Item
  attr_reader :attributes, :parent
  def initialize(item, parent)
    @attributes = {
      name:                    item[:name],
      id:                      item[:id].to_i,
      description:             item[:description],
      merchant_id:             item[:merchant_id].to_i,
      unit_price:  (BigDecimal(item[:unit_price]) / 100.0),
      created_at:   Time.parse(item[:created_at]),
      updated_at:   Time.parse(item[:updated_at])
    }
    @parent = parent
  end

  def name
    attributes[:name]
  end

  def id
    attributes[:id]
  end

  def description
    attributes[:description]
  end

  def merchant_id
    attributes[:merchant_id]
  end

  def unit_price
    attributes[:unit_price]
  end

  def created_at
    attributes[:created_at]
  end

  def updated_at
    attributes[:updated_at]
  end

  def unit_price_to_dollars
    attributes[:unit_price].to_f.round(2)
  end
end
