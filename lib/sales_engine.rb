require_relative 'sales_analyst'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

# Handles reading files for Repository classes for all similarly named instance
# classes, also collects instances for Analyst to use.
class SalesEngine
  attr_reader :files

  def initialize(files)
    @files = files
  end

  def items
    @items = ItemRepository.new(files[:items], self)
  end

  def merchants
    @merchants = MerchantRepository.new(files[:merchants], self)
  end

  def invoices
    @invoices = InvoiceRepository.new(files[:invoices], self)
  end

  def invoice_items
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
  end

  def transactions
    @transactions = TransactionRepository.new(files[:transactions], self)
  end

  def customers
    @customers = CustomerRepository.new(files[:customers], self)
  end

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

  def collect_transactions_by_invoice_id(id)
    transactions.find_all_by_invoice_id(id)
  end

  def collect_prices_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id)
  end 
end
