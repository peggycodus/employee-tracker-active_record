require 'active_record'
require './lib/employee'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  puts "Welcome"
  choice = nil

  until choice == "e"
    puts "Please press 'a' to add an employee."
    puts "Please press 'l' to list all employees."
    puts "Please press 'e' to exit the program."
    choice = gets.chomp

    case choice
    when "a"
      add_employee
    when "l"
      list_all_employees
    when "e"
      puts "Good-bye"
      exit
    else
      puts "Please enter a valid option."
    end

  end
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

main_menu
