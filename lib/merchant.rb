# :nodoc:
class Merchant
  attr_reader :id, :parent
  attr_accessor :name
  def initialize(merchant, parent)
    @id     = merchant[:id].to_i
    @name   = merchant[:name]
    @parent = parent
  end
end
