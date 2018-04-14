require_relative 'file_loader'
require_relative 'repository'
require_relative 'merchant'
require_relative 'repository'

# robocomment
class MerchantRepository

  include FileLoader
  include Repository
  attr_reader :merchants, :parent
  def initialize(filepath, parent)
    @merchants = []
    @parent = parent
    @unchangeable_keys = %I[id]
    load_attributes(filepath, @merchants, Merchant)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    find_by_instance_id(@merchants, id)
  end

  def find_by_name(name)
    find_by_instance_name(@merchants, name)
  end

  def delete(id)
    delete_instance(@merchants, id)
  end

  def find_all_by_name(name)
    find_all_with_instance_name(@merchants, name)
  end

  def create(attributes)
    create_new_instance(@merchants, attributes, Merchant)
  end

  def update(id, attributes)
    update_instance(id, attributes, @merchants, @unchangeable_keys)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def collect_id_for_items(id)
    parent.collect_items_by_merchant_id(id)
  end
end
