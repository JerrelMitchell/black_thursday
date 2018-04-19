# Stores instance attributes generated from SalesEngine.
class Merchant
  attr_reader :attributes
  def initialize(merchant, parent)
    @attributes = {
      id:    merchant[:id].to_i,
      name:  merchant[:name]
    }
    @parent = parent
  end

  def id
    attributes[:id]
  end

  def name
    attributes[:name]
  end

  def items
    @parent.collect_id_for_items(id)
  end

  def invoices
    @parent.collect_id_for_invoices(id)
  end
end
