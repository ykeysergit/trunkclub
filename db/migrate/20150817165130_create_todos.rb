class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.date :due_date

      t.timestamps null: false
    end
  end
end
