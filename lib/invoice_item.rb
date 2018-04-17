# :nodoc:
class InvoiceItem
  attr_reader :attributes, :parent

  def initialize(invoice_item, parent)
    @attributes = {
      id:           invoice_item[:id].to_i,
      item_id:      invoice_item[:item_id].to_i,
      invoice_id:   invoice_item[:invoice_id].to_i,
      quantity:     invoice_item[:quantity].to_i,
      unit_price:   (BigDecimal(invoice_item[:unit_price]) / 100.0),
      created_at:   Time.parse(invoice_item[:created_at]),
      updated_at:   Time.parse(invoice_item[:updated_at])
    }
    @parent = parent
  end

  #add tests

  def id
    attributes[:id]
  end

  def item_id
    attributes[:item_id]
  end

  def invoice_id
    attributes[:invoice_id]
  end

  def quantity
    attributes[:quantity]
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
end
