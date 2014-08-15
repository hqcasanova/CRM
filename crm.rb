require_relative 'contact.rb'
require_relative 'rolodex.rb'

# As a user, I am presented with a prompt to 'add', 'modify', 'display all', 'display one'
class CRM

  #Factory method
  def self.run(name)
    crm = CRM.new(name)
    puts crm
    crm.main_menu
  end

  def initialize(name)
    @name = name
    @rolodex = Rolodex.new
  end

  def to_s
    @name
  end

  def print_main_menu
    puts "[1] Add a contact"
    puts "[2] Modify a contact"
    puts "[3] Display all contacts"
    puts "[4] Display one contact"
    puts "[5] Display a contact's attribute"
    puts "[6] Delete a contact"
    puts "[7] Exit"
    print "Choose an option by entering a number: "
  end

  #Main loop
  def main_menu
    input = 0
    until input == 7 
      print_main_menu
      input = gets.chomp.to_i
      call_option(input)
    end
  end

  def add_contact
    print "First name: "
    first_name = gets.chomp
    print "Last name: "
    last_name = gets.chomp
    print "E-mail: "
    email = gets.chomp
    print "Notes: "
    notes = gets.chomp 
    contact = @rolodex.add_contact(Contact.new(first_name, last_name, email, notes))
    puts "\nContact added to rollodex:\n#{contact}\n" 
  end

  def call_option(input)
    case input
    when 1
      add_contact
    when 2
      puts "modify"
    when 3
      puts "all"
    when 4
      puts "one"
    when 5

    when 6

    when 7

    else     
      puts "Error: option #{input} not recognized."
    end
  end
end

CRM.run("Customer Relationship Manager")