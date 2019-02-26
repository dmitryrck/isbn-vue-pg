class CreatePgIsbns < ActiveRecord::Migration[5.2]
  def change
    create_table :pg_isbns do |t|
      t.string :isbn, limit: 12
      t.string :digit, limit: 1

      t.timestamps
    end
  end
end
