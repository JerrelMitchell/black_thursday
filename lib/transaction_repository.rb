require_relative '../modules/repository'
require_relative '../modules/file_loader'
require_relative 'transaction'

# :nodoc:
class TransactionRepository
  include FileLoader
  include Repository
  attr_reader :transactions
  def initialize(filepath, parent)
    @transactions = []
    @parent = parent
    @unchangeable_keys = %I[id invoice_id created_at]
    load_attributes(filepath, @transactions, Transaction)
  end

  #refactor and update methods and add tests

  def all
    @transactions
  end

  def find_by_id(id)
    find_with_id(@transactions, id)
  end

  def find_all_by_invoice_id(id)
    find_all_with_instance_key(@transactions, id, :invoice_id)
  end

  def find_all_by_credit_card_number(card_number)
    find_all_with_instance_key(@transactions, card_number, :credit_card_number)
  end

  def find_all_by_result(result)
    find_all_with_status(@transactions, result)
  end

  def delete(id)
    delete_instance(@transactions, id)
  end

  def create(attributes)
    create_new_instance(@transactions, attributes, Transaction)
  end

  def update(id, attributes)
    update_instance(id, attributes, @transactions, @unchangeable_keys)
  end

  def inspect
    inspect_instance(self, @transactions)
  end
end
