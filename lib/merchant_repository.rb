# frozen_string_literal true
require 'csv'
require_relative 'merchant'
# robocomment
class MerchantRepository
  attr_reader :merchants

  def initialize(filepath)
    @merchants = []
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
