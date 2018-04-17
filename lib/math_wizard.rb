# :nodoc:
module MathWizard
  def average(numerator, denominator)
    (BigDecimal(numerator) / BigDecimal(denominator)).round(2)
  end

  def standard_deviation(data, average)
    result = data.map do |item|
      (item - average)**2
    end.reduce(:+) / (data.length - 1)
    Math.sqrt(result)
  end
end
