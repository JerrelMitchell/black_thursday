
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
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
    merchant.id == id
   end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

end
