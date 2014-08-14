class CreateTeamProject < ActiveRecord::Migration
  def change
    create_table :team_projects do |t|
      t.belongs_to :employee
      t.belongs_to :project

      t.timestamps
    end
  end
end
