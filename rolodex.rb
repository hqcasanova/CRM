class Rolodex
  def initialize
    @contacts = []
    @index = 1000
  end

  #Creates a new contact, adds it to the array, updates the current index
  #Returns the new contact
  def add_contact(first_name, last_name, email, notes)
    @contacts << Contact.new(@index, first_name, last_name, email, notes)
    @index += 1
    @contacts[-1]
  end

  #Searches for a certain contact according to email
  #Returns the corresponding contact or false if not found
  def search_contact(email)
    @contacts.each do |contact|
      if contact.email == email
        return contact 
      end  
    end
    return false 
  end

  #Modifies the attribute, identified by 'attr_code', of a certain contact selected by email
  #Returns the modified contact object unless an error occurred, in which case false is returned instead.
  def modify_contact(contact, attr_code, new_value)
    case attr_code
    when 0
      contact.first_name = new_value
    when 1
      contact.last_name = new_value
    when 2
      contact.email = new_value
    when 3
      contact.notes = new_value
    else
      contact = false
    end  
    return contact
  end


  def display_all_contacts
  
  end
  def display_particular_contact
  end
  def display_info_by_attribute
  end
  def delete_contact
  end  
end