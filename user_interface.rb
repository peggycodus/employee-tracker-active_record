require 'active_record'
require './lib/employee'
require './lib/division'
require './lib/project'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  puts "Welcome"
  choice = nil

  until choice == "e"

    puts "Please press '1' for divisions ."
    puts "Please press '2' for employees."
    puts "Please press '3' for projects"
    puts "Please press 'e' to exit the program."
    choice = gets.chomp

    case choice
    when "1"
      division_menu
    when "2"
      employee_menu
    when "3"
      project_menu
    when "e"
      puts "Good-bye"
      exit
    else
      puts "Please enter a valid option."
    end
  end
end

def employee_menu

  choice = nil
  until choice == "e"
    puts "Please press 'a' to add an employee."
    puts "Please press 'l' to list all employees."
    puts "Please press 'd' to delete an employee."
    puts "Please press 'r' to return to main menu."
    puts "Please press 'e' to exit the program."
    choice = gets.chomp

    case choice
    when "a"
      add_employee
    when "l"
      list_all_employees
    when "c"
      add_employee_project_contribution
    when "d"
      delete_employee
    when "e"
      puts "Good-bye"
      exit
    when "r"
      main_menu
    else
      puts "Please enter a valid option."
    end
    employee_menu
  end
end

def division_menu

  choice = nil
  until choice == "e"
    puts "Please press 'a' to add a division."
    puts "Please press 'l' to list all divisions."
    puts "Please press 'd' to delete a division."
    puts "Please press 'e' to exit the program."
    puts "Please press 'r' to return to main menu."
    choice = gets.chomp

    case choice
    when "a"
      add_division
    when "l"
      list_all_divisions
      employee_by_division
    when "d"
      delete_division
    when "e"
      puts "Good-bye"
      exit
    when "r"
      main_menu
    else
      puts "Please enter a valid option."
    end
    division_menu
  end
end

def project_menu
  choice = nil
  until choice == "e"
    puts "Please press 'a' to add a project."
    puts "Please press 'l' to list all projects."
    puts "Please press 'd' to delete a project."
    puts "Please press 'e' to exit the program."
    puts "Please press 'r' to return to main menu."
    choice = gets.chomp

    case choice
    when "a"
      add_project
    when "l"
      list_all_projects
    when "d"
      delete_project
    when "e"
      puts "Good-bye"
      exit
    when "r"
      main_menu
    else
      puts "Please enter a valid option."
    end
    project_menu
  end
end

def add_project
  puts "Please enter the name of the project you want to add."
  project_name = gets.chomp.capitalize
  puts "Please enter a start date for the project (e.g. 2011-04-20)."
  start_date = gets.chomp
  puts "Please enter an end date for the project (e.g. 2012-12-34)."
  end_date = gets.chomp
  new_project = Project.new(name: project_name, start_date: start_date, end_date: end_date)
  new_project.save
  puts "You have added #{new_project.name} as a new project."
end


def list_all_projects
  puts "Here is a list of all the projects."
  project_list = Project.all
  project_list.each { |project| puts "#{project.name} #{project.start_date} #{project.end_date}"}
end

def delete_project
  puts "Type in the name of the project you want to delete."

  list_all_projects
  name = gets.chomp
  delete_project = Project.find_by(name: name)
  delete_project.destroy
end

def add_employee
  puts "Please enter the first name of the employee you want to add."
  first_name = gets.chomp.capitalize
  puts "Please enter the last name."
  last_name = gets.chomp.capitalize
  puts "Please enter the name of the division this employee belongs to."
  list_all_divisions
  division_name = gets.chomp
  division_id = Division.find_by(name: division_name).id
  new_employee = Employee.new({first_name: first_name, last_name: last_name, division_id: division_id})
  new_employee.save
  puts "You have added #{first_name} #{last_name} as an employee."
end

def list_all_employees
  puts "Here are all of the Employees:"
  employees_list = Employee.all
  employees_list.each { |employee| puts "#{employee.first_name} #{employee.last_name}"}
end

def add_employee_project_contribution
list_all_projects
puts " Enter a project name to add a contribution"
project_name = gets.chomp.capitalize
puts "Enter the employee's first name"
first_name = gets.chomp.capitalize
puts "Please enter the employee's last name."
puts "Enter the employees last name"
last_name = gets.chomp.capitalize
Puts "enter the description for the employee contribution"
description = gets.chomp
project_id = Project.find_by(name: project_name).id
employee_id = Employee.find_by(first_name: first_name, last_name: last_name).id
new_contribution = TeamProject.new({project_id:})
end


def delete_employee
  puts "Please enter the first name of the employee you want to delete."
  first_name = gets.chomp.capitalize
  puts "Please enter the last name of the employee."
  last_name = gets.chomp.capitalize

  new_employee = Employee.find_by(first_name: first_name, last_name: last_name)
  new_employee.destroy

  puts "You have successfully delete #{first_name} #{last_name}."
end

def add_division
  puts "Please enter the name of the division you want to add."
  division_name = gets.chomp

  new_division = Division.new({name: division_name})
  new_division.save
  puts "You have add #{new_division.name} as a new division."
end

def delete_division
  puts "Please enter the name of the division you want to delete."
  division_name = gets.chomp

  delete_division = Division.find_by(name: division_name)
  delete_division.destroy

  puts "You have successfully deleted #{division_name}."
end

def list_all_divisions
  puts "Here are all of the Divisions:"
  divisions_list = Division.all
  divisions_list.each {|division| puts "#{division.name}"}
end

def employee_by_division
  puts "Type in the division name if you want to see which employees are part of that specific division, else press 'x' to exit back to the division_menu."
  answer = gets.chomp

  case
  when answer == "x"
    division_menu
  when Division.where(name: answer).count == 0
    puts" please enter an existing division name"
    list_all_divisions
  else
    selected_division_list = []
    selected_division_id = Division.find_by(name: answer).id
    employee_division_list = Employee.where(division_id: selected_division_id)

    employee_division_list.each do |employee|
      if employee_division_list == []
        puts "There are no employees in this division yet."
      else
        puts "#{employee.first_name} #{employee.last_name}"
      end
    end
  end

end
main_menu
