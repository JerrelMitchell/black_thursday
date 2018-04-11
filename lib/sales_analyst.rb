require_relative 'sales_engine'

class SalesAnalyst

  def initialize

  end

  def average_items_per_merchant
    @merchants.reduce(0) do |merchant|
      merchant.items.length #can we use reduce here??
    end
    # find average items per merchant
  end

  def merchants_with_high_item_count
    @merchants.sort_by do |merchant|
      merchant.items.length
    end
  end


end
