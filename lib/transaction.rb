require 'time'

# Stores instance attributes generated from SalesEngine.
class Transaction
  attr_reader :attributes, :parent

  def initialize(transaction, parent)
    @attributes = {
      id:                          transaction[:id].to_i,
      invoice_id:                  transaction[:invoice_id].to_i,
      result:                      transaction[:result].to_sym,
      credit_card_number:          transaction[:credit_card_number],
      credit_card_expiration_date: transaction[:credit_card_expiration_date],
      created_at:       Time.parse(transaction[:created_at]),
      updated_at:       Time.parse(transaction[:updated_at])
    }
    @parent = parent
  end

  def id
    attributes[:id]
  end

  def invoice_id
    attributes[:invoice_id]
  end

  def result
    attributes[:result]
  end

  def credit_card_number
    attributes[:credit_card_number]
  end

  def credit_card_expiration_date
    attributes[:credit_card_expiration_date]
  end

  def created_at
    attributes[:created_at]
  end

  def updated_at
    attributes[:updated_at]
  end
end
