require 'csv'
require_relative 'merchant'

# robocomment
class MerchantRepository
  attr_reader :merchants
  def initialize(filepath, parent)
    @merchants = []
    @parent = parent
    load_merchants(filepath)
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    CSV.foreach(filepath,
                headers: true,
                header_converters: :symbol) do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      return nil if merchant.name.nil?
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    merchant_instance = find_by_id(id)
    @merchants.delete(merchant_instance)
  end

  def create(name)
    new_merchant_id = @merchants.map(&:id).max + 1
    new_merchant_attributes = { name: name, id: new_merchant_id }
    @merchants << Merchant.new(new_merchant_attributes, self)
  end

  def update(id, new_name)
    current = find_by_id(id)
    return nil if current.nil?
    current.name = new_name
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
