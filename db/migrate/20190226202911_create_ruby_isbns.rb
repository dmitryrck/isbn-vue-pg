class CreateRubyIsbns < ActiveRecord::Migration[5.2]
  def change
    create_table :ruby_isbns do |t|

      t.timestamps
    end
  end
end
