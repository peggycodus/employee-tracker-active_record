class Project < ActiveRecord::Base
  has_many :employees, :through => :teamProjects
end


