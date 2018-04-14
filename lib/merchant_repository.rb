require_relative 'file_loader'
require_relative 'repository'
require_relative 'merchant'

# robocomment
class MerchantRepository
  include FileLoader
  include Repository
  attr_reader :merchants, :parent
  def initialize(filepath, parent)
    @merchants = []
    @parent = parent
    load_attributes(filepath, @merchants, Merchant)
  end

  def all
    find_all_attributes(@merchants)
  end

  def find_by_id(id)
    find_by_attribute_id(@merchants, id)
  end

  def find_by_name(name)
    find_by_attribute_name(@merchants, name)
  end

  def delete(id)
    delete_attribute(@merchants, id)
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    new_id = (@merchants.map(&:id).max + 1)
    attributes[:id] = new_id
    @merchants << Merchant.new(attributes, self)
  end

  def update(id, attributes)
    current_instance = find_by_id(id)
    return nil if current_instance.nil?
    current_instance.attributes[:name] = attributes[:name]
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def pass_id_to_sales_engine(id)
    parent.pass_id_to_item_repo(id)
  end
end
