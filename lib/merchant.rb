# :nodoc:
class Merchant
  attr_reader :parent
  attr_accessor :id, :name
  def initialize(merchant, parent)
    @id     = merchant[:id].to_i
    @name   = merchant[:name]
    @parent = parent
  end
end
