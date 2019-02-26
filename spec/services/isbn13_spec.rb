require "isbn13"

describe ISBN13 do
  context "#check_digit" do
    [
      { barcode: "978014300723", expected: 4 },
      { barcode: "978186197271", expected: 2 },
      { barcode: "978186197876", expected: 9 },
      { barcode: "978316148410", expected: 0 },
    ].each do |test_case|
      it do
        expect(ISBN13.check_digit(test_case[:barcode])).to eq test_case[:expected]
      end
    end
  end
end
