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

  def pass_merchant_id_to_merchant_repo(id)
    merchants.find_by_id(id)
  end

  def pass_id_to_item_repo(id)
    items.find_all_by_merchant_id(id)
  end
end
