class Employee < ActiveRecord::Base
  belongs_to :division
  has_many :projects, :through => :teamProjects
end
