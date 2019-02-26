class RubyIsbn < ApplicationRecord
  before_validation do |record|
    record.digit = ISBN13.check_digit(record.isbn)
  end
end
