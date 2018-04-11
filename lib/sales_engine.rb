require_relative 'merchant_repository'
require_relative 'item_repository'

# :nodoc:
class SalesEngine
  attr_accessor :items, :merchants, :analyst

  def initialize(files)
    @items     = ItemRepository.new(files[:items], self)
    @merchants = MerchantRepository.new(files[:merchants], self)
    @analyst   = SalesAnalyst.new
  end

  def self.from_csv(files)
    new(files)
  end

end
