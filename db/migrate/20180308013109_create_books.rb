class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :year_published
      t.string :language
      t.string :status
      t.integer :borrower
      t.integer :user_id
      t.string :description

      t.timestamps null: false
    end
  end
end
