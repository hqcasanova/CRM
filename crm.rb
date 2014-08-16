require_relative 'contact.rb'
require_relative 'rolodex.rb'

##########Builds and displays the user interface, gathering any required data and passing it to the layers below
class CRM
  #Messages
  @@main_ops = [
    "Add a contact",
    "Modify a contact's attribute",
    "Display all contacts",
    "Display one contact",
    "Display an attribute for all contacts",
    "Delete a contact",
    "Exit"
  ]
  @@update_ops = [
    "First name", 
    "Last name", 
    "Email", 
    "Notes"
  ]

  #Factory method
  def self.run(name)
    crm = CRM.new(name)
    crm.main_menu
  end

  #Constructor
  def initialize(name)
    @name = name
    @rolodex = Rolodex.new
  end

  #String representation
  def to_s
    @name
  end

  #Displays a menu of multiple options, each on its own line
  def print_menu(options)
    i = 0
    options.each do |attribute|
      puts "[#{i}] #{attribute}"
      i += 1
    end
  end

  #Main loop: displays the main menu and waits for the user's input before calling the corresponding option.
  #It also waits for input after the option has been executed, in case any results from the latter are displayed.
  def main_menu
    input = 0
    until input == 6 
      print "\e[H\e[2J"  #clears the screen
      puts @name          
      print_menu(@@main_ops)
      print "Choose an option by entering a number: "
      input = gets.chomp.to_i
      call_option(input)
      if input != 6
        print "Press Enter/Return to continue..."
        gets
      else
        puts "Thanks for using our software services."
      end
    end
  end

  #Gathers the information needed for a new Rolodex contact
  #Returns the new contact 
  def add_contact
    puts "NEW CONTACT"
    puts "Please provide the information specified below"
    print "First name: "
    first_name = gets.chomp
    print "Last name: "
    last_name = gets.chomp
    print "E-mail: "
    email = gets.chomp
    print "Notes: "
    notes = gets.chomp 
    contact = @rolodex.add_contact(first_name, last_name, email, notes)
    puts "\nContact successfully added to Rolodex:\n#{contact}\n"
    return contact
  end

  #Updates a user-chosen attribute of a contact identified by an email (also provided by the user).
  #Returns the updated contact or false if such update was unsuccessful.
  def modify_contact
    puts "MODIFY CONTACT"
    print "Please, provide the email of the contact to modify: "
    contact = @rolodex.search_contact(gets.chomp)
    
    #Contact found => choose attribute
    if contact
      puts "\n#{contact}\n" 
      print_menu(@@update_ops)
      print "Which attribute would you want to modify? "
      attr_code = gets.chomp.to_i

      #Valid attribute code => confirm and update
      if (attr_code < @@update_ops.length) && (attr_code >= 0)
        print "You have chosen to change the contact's #{@@update_ops[attr_code]}. Is that correct? "
        confirm = gets.chomp.downcase
        if confirm == 'yes'
          print "Please provide the new value for #{@@update_ops[attr_code]}: "
          new_value = gets.chomp
          contact = @rolodex.modify_contact(contact, attr_code, new_value)
          puts "\nContact successfully updated:\n#{contact}\n"
        elsif confirm == 'no'
          print "Update canceled. "
        else
          puts "Error: only 'yes' and 'no' are valid responses."
        end
      else
        puts "Error: invalid attribute." 
      end
    else
      puts "Error: contact not found."
    end 
    return contact
  end

  def call_option(input)
    print "\e[H\e[2J"  #clears the screen
    case input
    when 0
      add_contact
    when 1
      modify_contact
    when 2
      puts "all"
    when 3
      puts "one"
    when 4

    when 5

    when 6

    else     
      puts "Error: option #{input} not recognized."
    end
  end
end

CRM.run("CUSTOMER RELATIONSHIP MANAGER")