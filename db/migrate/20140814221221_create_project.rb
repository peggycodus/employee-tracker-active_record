class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.column :name, :string
      t.column :start_date, :date
      t.column :end_date, :date
      t.timestamps
    end
  end
end
