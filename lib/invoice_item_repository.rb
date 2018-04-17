require_relative '../modules/repository'
require_relative '../modules/file_loader'
require_relative 'invoice_item'

# :nodoc:
class InvoiceItemRepository
  include FileLoader
  include Repository
  attr_reader :invoice_items
  def initialize(filepath, parent)
    @invoice_items = []
    @parent = parent
    @unchangeable_keys = %I[id invoice_id created_at]
    load_attributes(filepath, @invoice_items, InvoiceItem)
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    find_with_id(@invoice_items, id)
  end

  def find_all_by_item_id(id)
    find_all_with_instance_key(@invoice_items, id, :item_id)
  end

  def find_all_by_invoice_id(id)
    find_all_with_instance_key(@invoice_items, id, :invoice_id)
  end

  def create(attributes)
    create_new_instance(@invoice_items, attributes, InvoiceItem)
  end

  def update(id, attributes)
    update_instance(id, attributes, @invoice_items, @unchangeable_keys)
  end

  def delete(id)
    delete_instance(@invoice_items, id)
  end

  def inspect
    inspect_instance(self, @invoice_items)
  end
end
