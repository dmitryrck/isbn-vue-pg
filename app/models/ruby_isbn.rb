class RubyIsbn < ApplicationRecord
  validates :isbn, length: { is: 12 }

  before_validation do |record|
    record.digit = ISBN13.check_digit(record.isbn)
  end
end
