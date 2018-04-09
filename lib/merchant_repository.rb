# frozen_string_literal true

# robocomment
class MerchantRepository
  attr_reader :attributes

  def initialize(merchant)
    @merchant = merchant
  end
end
