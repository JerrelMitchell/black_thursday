require_relative 'file_loader'
require_relative 'repository'
require_relative 'customer'

class CustomerRepository
  include FileLoader
  include Repository
  def initialize(filepath, parent)
    @customers = []
  end


end
