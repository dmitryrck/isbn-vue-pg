class RubyIsbn < ApplicationRecord
  before_validation do |record|
    return if record.isbn.blank?

    record.digit = ISBN13.check_digit(record.isbn)
  end
end
