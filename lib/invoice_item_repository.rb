require_relative 'file_loader'
require_relative 'repository'
require_relative 'invoice_item'

# :nodoc:
class InvoiceItemRepository
  include FileLoader
  include Repository
  attr_reader :invoice_items
  def initialize(filepath, parent)
    @invoice_items = []
    @parent = parent
    @unchangeable_keys = %I[id invoice_item_id created_at]
    load_attributes(filepath, @invoice_items, InvoiceItem)
  end

  #refactor and update methods and add tests

  def all
    @invoice_items
  end

  def find_by_id(id)
    find_with_id(@invoice_items, id)
  end

  def find_by_name(name)
    find_by_instance_string(@invoice_items, name, :name)
  end

  def find_all_with_description(description)
    find_all_with_instance_string(@invoice_items, description, :description)
  end

  def find_all_by_price(price)
    find_all_with_instance_key(@invoice_items, price, :unit_price)
  end

  def find_all_by_price_in_range(price_range)
    find_all_instances_in_price_range(@invoice_items, price_range)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_with_instance_key(@invoice_items, merchant_id, :merchant_id)
  end

  def delete(id)
    delete_instance(@invoice_items, id)
  end

  def create(attributes)
    create_new_instance(@invoice_items, attributes, InvoiceItem)
  end

  def update(id, attributes)
    update_instance(id, attributes, @invoice_items, @unchangeable_keys)
  end

  def inspect
    inspect_instance(self, @invoice_items)
  end
end
