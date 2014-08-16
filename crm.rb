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

  #Presents the user with a message requesting an email for the contact to be retrieved
  #Returns the contact if found or false if not. It also returns false if the Rolodex has no contacts
  #An error is printed out for the latter two cases.
  def retrieve_contact_by_email
    unless @rolodex.is_empty?
      print "Please, provide the email of the contact in question: "
      contact = @rolodex.search_contact(gets.chomp)
      if contact
        @rolodex.display_particular(contact)
      else
        puts "Error: contact not found."
      end
    else
      contact = false
      puts "Error: the Rolodex is empty."
    end
    return contact
  end

  #Updates a user-chosen attribute of a contact identified by an email (also provided by the user).
  #Returns the updated contact or false if such update was unsuccessful.
  def modify_contact
    puts "MODIFY CONTACT"
    contact = retrieve_contact_by_email

    #Contact found => choose attribute
    if contact
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
          contact = @rolodex.modify(contact, attr_code, new_value)
          if contact
            puts "Contact successfully updated:\n#{contact}\n"
          end
        elsif confirm == 'no'
          print "Update canceled. "
        else
          puts "Error: only 'yes' and 'no' are valid responses."
        end
      else
        puts "Error: invalid attribute." 
      end
    end 
    return contact
  end

  #Prints out all contacts with all their corresponding information
  def display_all_contacts
    puts "DISPLAY ALL CONTACTS"
    @rolodex.display_all_contacts
  end

  #Displays the information stored for a contact with a certain user-provided email
  def display_one_contact
    puts "DISPLAY ONE CONTACT"
    contact = retrieve_contact_by_email
  end

  def delete_contact
    puts "DELETE A CONTACT"
    contact = retrieve_contact_by_email
    if contact
      if @rolodex.delete(contact)
         puts "Contact successfully deleted."
      end
    end
  end  

  #Option-action router
  def call_option(input)
    print "\e[H\e[2J"  #clears the screen
    case input
    when 0
      add_contact
    when 1
      modify_contact
    when 2
      display_all_contacts
    when 3
      display_one_contact
    when 4

    when 5
      delete_contact
    when 6
      puts "Thanks for using our software services."   
    else     
      puts "Error: option #{input} not recognized."
    end
  end
end

CRM.run("CUSTOMER RELATIONSHIP MANAGER")

#Note: menus displayed using this class can be further generalized and "objectified". Also, 
#instructions regarding display of messages have been allowed to be repeated for the sake of further
#simplification of underlying classes and total separation between view and logic.