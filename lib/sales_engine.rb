require_relative 'sales_analyst'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

# :nodoc:
class SalesEngine
  attr_reader :items, :merchants, :invoices

  def initialize(files)
    @items         = ItemRepository.new(files[:items], self)
    @merchants     = MerchantRepository.new(files[:merchants], self)
    @invoices      = InvoiceRepository.new(files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
    @transactions  = TransactionRepository.new(files[:transactions], self)
    # @customers     = CustomerRepository.new(files[:customers], self)
  end

  #update tests

  def self.from_csv(files)
    new(files)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def collect_invoices_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

  def collect_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end
end
