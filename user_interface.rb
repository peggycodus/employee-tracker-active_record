require 'active_record'
require './lib/employee'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  puts "Welcome"
  choice = nil

  until choice == "e"

    puts "Please press '1' for divisions ."
    puts "Please press '2' for employees."
    puts "Please press 'e' to exit the program."
    choice = gets.chomp

    case choice
    when "1"
      division_menu
    when "2"
      employee_menu
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
    puts "Please press 'e' to exit the program."
    choice = gets.chomp

    case choice
    when "a"
      add_employee
    when "l"
      list_all_employees
    when "d"
      delete_employee
    when "e"
      puts "Good-bye"
      exit
    else
      puts "Please enter a valid option."
    end
    employee_menu
  end
end

def division_menu

end

def add_employee
  puts "Please enter the first name of the employee you want to add."
  first_name = gets.chomp.capitalize
  puts "Please enter the last name."
  last_name = gets.chomp.capitalize

  new_employee = Employee.new({first_name: first_name, last_name: last_name})
  new_employee.save
  puts "You have add #{first_name} #{last_name} as an employee."
end

def list_all_employees
  puts "Here are all of the Employees:"
  employees_list = Employee.all
  employees_list.each { |employee| puts "#{employee.first_name} #{employee.last_name}"}
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

def list_all_divisions
  puts "Here are all of the Divisions:"
  divisions_list = Division.all
  divisions_list.each {|division| puts "#{division.name}"}
end

main_menu
