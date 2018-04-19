require './test/test_helper'
require_relative '../lib/sales_engine'

# :nodoc:
class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repo
  def setup
    engine = SalesEngine.from_csv(
      transactions: './fixtures/fixture_transactions.csv'
    )
    @transaction_repo = engine.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, transaction_repo
  end

  def test_it_has_all_transactions_in_array_and_all_transactions_are_transactions
    assert_instance_of Array, transaction_repo.all
    assert_equal 100, transaction_repo.all.count
    assert(transaction_repo.all.all? { |transaction| transaction.is_a?(Transaction) })
  end

  def test_it_can_find_specified_transaction_by_id
    result1 = transaction_repo.find_by_id(28)
    assert_equal 28, result1.id

    result2 = transaction_repo.find_by_id(44)
    assert_equal 44, result2.id

    assert_nil transaction_repo.find_by_id(0)
  end

  def test_it_can_find_all_transactions_that_share_invoice_id
    result1 = transaction_repo.find_all_by_invoice_id(3477)
    assert_equal Transaction, result1.first.class
    assert_equal 2,           result1.size

    result2 = transaction_repo.find_all_by_invoice_id(520)
    assert_equal Transaction, result2.last.class
    assert_equal 4,           result2.size

    result3 = transaction_repo.find_all_by_invoice_id(0)
    assert_equal [], result3
  end

  def test_it_can_find_all_transactions_that_share_credit_card_number
    result1 = transaction_repo.find_all_by_credit_card_number('4005021410252154')
    assert_equal Transaction, result1.first.class
    assert_equal 4,           result1.size

    result2 = transaction_repo.find_all_by_credit_card_number('4391575588388370')
    assert_equal Transaction, result2.last.class
    assert_equal 3,           result2.size

    result3 = transaction_repo.find_all_by_credit_card_number(0)
    assert_equal [], result3
  end

  def test_it_can_find_all_transactions_that_share_a_result
    result1 = transaction_repo.find_all_by_result(:success)
    assert_equal Transaction, result1.first.class
    assert_equal 77,          result1.size

    result2 = transaction_repo.find_all_by_result(:failed)
    assert_equal Transaction, result2.last.class
    assert_equal 23,          result2.size

    result3 = transaction_repo.find_all_by_result('example invalid input')
    assert_equal [], result3
  end

  def test_it_can_delete_a_transaxction_from_list
    result1 = transaction_repo.find_by_id(44)
    assert_equal 44, result1.id

    transaction_repo.delete(44)

    assert_nil transaction_repo.find_by_id(44)
  end

  def test_it_can_create_a_new_transaction_and_add_it_to_list
    assert_nil transaction_repo.find_by_id(101)

    transaction_repo.create(invoice_id: 808,
                            result: 'success',
                            credit_card_number: '1234567890',
                            credit_card_expiration_date: '1234')

    result1 = transaction_repo.find_by_id(101)
    assert_equal 101,           result1.id
    assert_equal :success,      result1.result
    assert_equal '1234567890',  result1.credit_card_number
    assert_equal Time.now.to_s, result1.created_at.to_s
  end

  def test_it_can_update_an_existing_transaction_instance
    result1 = transaction_repo.find_by_id(9)
    assert_equal '4463525332822998', result1.credit_card_number
    assert_equal '0618',             result1.credit_card_expiration_date
    assert_equal :failed,            result1.result

    transaction_repo.update(9, result: 'success',
                               credit_card_number: '1234567890',
                               credit_card_expiration_date: '1234')

    result2 = transaction_repo.find_by_id(9)
    assert_equal '1234567890',  result2.credit_card_number
    assert_equal '1234',        result2.credit_card_expiration_date
    assert_equal :success,      result2.result
    assert_equal Time.now.to_s, result2.updated_at.to_s
  end

  def test_can_inspect_number_of_self_instances
    assert_equal '#<TransactionRepository 100 rows>', transaction_repo.inspect
  end
end
