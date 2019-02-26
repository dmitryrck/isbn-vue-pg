class ISBN13
  def self.check_digit(barcode)
    new(barcode).check_digit
  end

  def initialize(barcode)
    @barcode = barcode
  end

  def check_digit
    calculate_using_mod10(sum_numbers(barcode.each_char.to_a))
  end

  private

  attr_reader :barcode

  def calculate_using_mod10(number)
    mod10 = number % 10

    if mod10 != 0
      10 - mod10
    else
      0
    end
  end

  def sum_numbers(numbers)
    numbers.each_with_index.map do |char, index|
      char.to_i * (index.succ.even? ? 3 : 1)
    end.sum
  end
end
