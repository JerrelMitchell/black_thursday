require './test/test_helper'
require_relative '../lib/transaction'

# :nodoc:
class TransactionTest < Minitest::Test
  attr_reader :transaction
  def setup
    @transaction = Transaction.new({
                                     id: '5',
                                     invoice_id: '2179',
                                     result: 'success',
                                     credit_card_number: '404803345106737',
                                     credit_card_expiration_date: '0313',
                                     created_at: '2012-02-26 20:56:56 UTC',
                                     updated_at: '2012-02-26 20:56:56 UTC'
                                   },
                                   'parent')
  end

  def test_it_exists
    assert_instance_of Transaction, transaction
  end

  def test_it_has_attributes
    assert_equal 5,                 transaction.id
    assert_equal 2179,              transaction.invoice_id
    assert_equal :success,          transaction.result
    assert_equal '404803345106737', transaction.credit_card_number
    assert_equal '0313',            transaction.credit_card_expiration_date
  end

  def test_it_can_show_times_when_created_and_updated
    creation_date = '2012-02-26 20:56:56 UTC'
    updated_date = '2012-02-26 20:56:56 UTC'
    assert_equal creation_date, transaction.created_at.to_s
    assert_equal updated_date, transaction.updated_at.to_s
  end
end
