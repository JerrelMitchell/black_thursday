require_relative '../modules/file_loader'
require_relative '../modules/repository'
require_relative 'customer'

class CustomerRepository
  include FileLoader
  include Repository
  def initialize(filepath, parent)
    @customers = []
    @parent = parent
    @unchangeable_keys = %I[id created_at]
    load_attributes(filepath, @customers, Customer)
  end

  def all
    @customers
  end

  def find_by_id(id)
    find_with_id(@customers, id)
  end

  def find_all_by_first_name
    find_by_instance_string(@customers, first_name, :first_name)
  end

  def find_all_by_last_name
    find_by_instance_string(@customers, last_name, :last_name)
  end

  def create(attributes)
    create_new_instance(@customers, attributes, Customer)
  end

  def update(id, attributes)
    update_instance(id, attributes, @customers, @unchangeable_keys)
  end

  def delete(id)
    delete_instance(@customers, id)
  end

  def inspect
    inspect_instance(self, @customers)
  end
end
