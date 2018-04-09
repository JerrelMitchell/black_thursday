# frozen_string_literal: true

class FileReader
  attr_reader :file_name
  def initialize(file_name)
    @file_name = file_name
  end

  def load_file(file_name)
    CSV.open('./data/small_items.csv'), headers: true, header_converters: :symbol
  end

end
