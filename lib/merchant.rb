# Stores instance attributes generated from SalesEngine.
class Merchant
  attr_reader :attributes, :parent
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
end
