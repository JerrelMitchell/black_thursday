require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'

# :nodoc:
class SalesEngine
  attr_reader :items, :merchants

  def initialize(files)
    @items     = ItemRepository.new(files[:items], self)
    @merchants = MerchantRepository.new(files[:merchants], self)
  end

  def self.from_csv(files)
    new(files)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
