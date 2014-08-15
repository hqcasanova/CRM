class Contact
  attr_accessor :id, :first_name, :last_name, :email, :notes

  def initialize(first_name, last_name, email, notes)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @notes = notes
  end

  def to_s
    "First name: #{@first_name}\n" +
    "Last name: #{@last_anem}\n" +
    "E-mail: #{@email}\n" +
    "Notes: #{@notes}\n"
  end
end