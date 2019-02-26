class AddIsbnAndDigitToRubyIsbns < ActiveRecord::Migration[5.2]
  def change
    change_table :ruby_isbns do |t|
      t.string :isbn, limit: 12
      t.string :digit, limit: 1
    end
  end
end
