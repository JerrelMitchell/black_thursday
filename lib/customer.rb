require 'time'

class Customer
  attr_reader :attributes, :parent
  def initialize(customer, parent)
    @attributes = {
      id:          customer[:id].to_i,
      first_name: customer[:first_name],
      last_name:  customer[:last_name],
      created_at: Time.parse(customer[:created_at]),
      updated_at: Time.parse(customer[:updated_at])
    }
    @parent = parent
  end

  def id
    attributes[:id]
  end

  def first_name
    attributes[:first_name]
  end

  def last_name
    attributes[:last_name]
  end

  def created_at
    attributes[:created_at]
  end

  def updated_at
    attributes[:updated_at]
  end
end
