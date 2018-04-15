# :nodoc:
module MathWizard
  def average(numerator, denominator)
    (BigDecimal(numerator, 4) / BigDecimal(denominator, 4)).round(2)
    # take out 4? BigDecimal should default to the correct amount of decimal points
  end

  def standard_deviation(data, average)
    result = data.map do |item|
      (item - average)**2
    end.reduce(:+) / (data.length - 1)
    Math.sqrt(result)
  end
end
