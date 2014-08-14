class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.column :first_name :string
      t.column :last_name :string
      t.column :division :string
    end
  end
end
