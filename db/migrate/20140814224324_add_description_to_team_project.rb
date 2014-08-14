class AddDescriptionToTeamProject < ActiveRecord::Migration
  def change
  end

  add_column :team_projects, :description, :string
end
