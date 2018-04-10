<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> 2e13b95e254c9878d624bba93b37cd1397d517c8
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
end
