class Transaction
  attr_reader :attributes, :parent

  def initialize(action, parent)
    @attributes = {
      id:                 action[:id].to_i,
      invoice_id:         action[:invoice_id].to_i,
      result:             action[:result],
      credit_card_number: action[:credit_card_number].to_i,
      credit_card_expiration_date: action[:credit_card_expiration_date].to_i,
      created_at:         Time.parse(action[:created_at]),
      updated_at:         Time.parse(action[:updated_at])
    }
    @parent = parent
  end

  #add tests

  def id
    attributes[:id]
  end

  def credit_card_number
    attributes[:credit_card_number]
  end

  def invoice_id
    attributes[:invoice_id]
  end

  def credit_card_expiration_date
    attributes[:credit_card_expiration_date]
  end

  def result
    attributes[:result]
  end

  def created_at
    attributes[:created_at]
  end

  def updated_at
    attributes[:updated_at]
  end
end