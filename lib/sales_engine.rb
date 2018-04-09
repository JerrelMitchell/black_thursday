# frozen_string_literal: true

require_relative 'file_reader'
require_relative 'merchant_repository'
require_relative 'item_repository'
class SalesEngine
  attr_reader :file_reader,
              :load_path
  def initialize(file_reader)
    @file_reader = FileReader.new(file_reader)
  end

  def self.from_csv(load_path)
    @load_path = load_path
  end

  def merchants
    loaded_file = file_reader(load_path[:merchants])
    MerchantRepository.new(loaded_file)
  end

  def items
    loaded_file = file_reader(load_path[:items])
    ItemRepository.new(loaded_file)
  end
end
