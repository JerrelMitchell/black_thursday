require_relative '../modules/file_loader'
require_relative '../modules/repository'
require_relative 'invoice'

# Loads and houses invoice instances generated by SalesEngine and can use
# repo module methods to search, inspect, create, update, and delete
# instances of Invoice.
class InvoiceRepository
  include FileLoader
  include Repository
  attr_reader :repository
  def initialize(filepath, parent)
    @repository = []
    @parent     = parent
    @unchangeable_keys = %I[id invoice_id customer_id created_at merchant_id]
    load_attributes(filepath, @repository, Invoice)
  end

  def all
    @repository
  end

  def find_by_id(id)
    find_with_id(@repository, id)
  end

  def find_all_by_customer_id(customer_id)
    find_all_with_instance_key(@repository, customer_id, :customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_with_instance_key(@repository, merchant_id, :merchant_id)
  end

  def find_all_by_status(status)
    find_all_with_status(@repository, status)
  end

  def delete(id)
    delete_instance(@repository, id)
  end

  def create(attributes)
    create_new_instance(@repository, attributes, Invoice)
  end

  def update(id, attributes)
    update_instance(id, attributes, @repository, @unchangeable_keys)
  end
end
