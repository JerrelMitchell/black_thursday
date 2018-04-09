# frozen_string_literal true

# robocomment
class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end
end
