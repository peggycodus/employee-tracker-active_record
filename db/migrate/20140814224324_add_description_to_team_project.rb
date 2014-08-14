class AddDescriptionToTeamProject < ActiveRecord::Migration
  def change
  end

  add_column :teamProjects, :description, :string
end
