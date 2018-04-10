# :nodoc:
class Merchant
  attr_accessor :id, :name
  def initialize(merchant)
    @id   = merchant[:id].to_i
    @name = merchant[:name]
  end
end
