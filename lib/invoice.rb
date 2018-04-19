require 'time'

# Stores instance attributes generated from SalesEngine.
class Invoice
  attr_reader :attributes, :parent
  def initialize(invoice, parent)
    @attributes = {
      id:                      invoice[:id].to_i,
      customer_id:             invoice[:customer_id].to_i,
      merchant_id:             invoice[:merchant_id].to_i,
      status:                  invoice[:status].to_sym,
      created_at:   Time.parse(invoice[:created_at]),
      updated_at:   Time.parse(invoice[:updated_at])
    }
    @parent = parent
  end

  def id
    attributes[:id]
  end

  def customer_id
    attributes[:customer_id]
  end

  def merchant_id
    attributes[:merchant_id]
  end

  def status
    attributes[:status]
  end

  def created_at
    attributes[:created_at]
  end

  def updated_at
    attributes[:updated_at]
  end
end
