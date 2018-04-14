require './test/test_helper'
require_relative '../lib/item'

class InvoiceTest < Minitest::Test

  def setup
       invoice = Invoice.new({
        id:           invoice[:id],
        customer_id:  invoice[:customer_id].to_i,
        merchant_id:  invoice[:merchant_id].to_i,
        status:       invoice[:status],
        created_at:   Time.parse(item[:created_at]),
        updated_at:   Time.parse(item[:updated_at])
      } 'parent')
  end


end
