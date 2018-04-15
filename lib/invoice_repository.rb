require_relative 'file_loader'
require_relative 'repository'
require_relative 'invoice'

# :nodoc:
class InvoiceRepository
  include FileLoader
  include Repository
  attr_reader :invoices
  def initialize(filepath, parent)
    @invoices = []
    @parent   = parent
    @unchangeable_keys = %I[id invoice_id customer_id created_at merchant_id]
    load_attributes(filepath, @invoices, Invoice)
  end

  def all
    @invoices
  end

  def find_by_id(id)
    find_with_id(@invoices, id)
  end

  def find_all_by_customer_id(customer_id)
    find_all_with_customer_id(@invoices, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_with_merchant_id(@invoices, merchant_id)
  end

  def find_all_by_status(status)
    find_all_with_status(@invoices, status)
  end

  def delete(id)
    delete_instance(@invoices, id)
  end

  def create(attributes)
    create_new_instance(@invoices, attributes, Invoice)
  end

  def update(id, attributes)
    update_instance(id, attributes, @invoices, @unchangeable_keys)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
