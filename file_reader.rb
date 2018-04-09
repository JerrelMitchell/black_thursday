# frozen_string_literal: true

class FileReader
  attr_reader :file_name
  def initialize(file_name)
    @file_name = File.read(file_name)
  end

end
