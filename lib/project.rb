class Project < ActiveRecord::Base
  has_many :employees, through :team_projects
end


