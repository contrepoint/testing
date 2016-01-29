require 'sqlite3'
require_relative 'setup_address_book.rb'

class Contacts

	# Add a contact
	def self.add_contact(first_name, last_name, company, phone_number, email_address)
		$db.execute(
			"
			INSERT INTO contacts
				(first_name, last_name, company, phone_number, email_address, created_at, updated_at)
			VALUES
				(?, ?, ?, ?, ?, DATETIME('now'), DATETIME('now'));
			",
			first_name, last_name, company, phone_number, email_address
		)
		puts "Added contact called #{first_name} #{last_name} to the contact database."
	end


	# Add a group
	def self.add_group(group_name)
		$db.execute(
			"
			INSERT INTO groups
				(group_name, created_at, updated_at)
			VALUES
				(?, DATETIME('now'), DATETIME('now'));
			",
			group_name
		)
		puts "Added group called #{group_name} to the groups database."
	end

	# Change a contact's email address
	def self.change_email_add(first_name, last_name, new_email_add)
		$db.execute(
			"
			UPDATE contacts
				SET email_address = ?
				WHERE first_name = ? AND last_name = ?;
			",
			new_email_add, first_name, last_name
		)

		puts "Updated #{first_name} #{last_name}'s email address to #{new_email_add}"
	end

	# Delete a contact
	def self.delete_contact(first_name, last_name)			# user supplies the first_name and last_name
		$db.execute(
			<<-SQL
				DELETE FROM contacts
				WHERE first_name = "#{first_name}" AND last_name = "#{last_name}";
			SQL
		)

		puts "Deleted contact called #{first_name} #{last_name} from the contact database."
	end

	# Delete a group - careful here - what does this mean? What implications does it have on your data?
	def self.delete_group(group_name)		 # user supplies the group name
		$db.execute(
			"
			DELETE FROM groups
			WHERE group_name = ?
			",
			group_name
		)

		puts "Deleted group called #{group_name} from groups database."
end

	# Show the contacts table
	def self.show_all_contacts
		puts "This is contacts table."
		print $db.execute(
			"
				SELECT * FROM contacts;
			"
		)
	end

	# Show the groups table
		def self.show_all_groups
		puts "This is the groups table."
		print $db.execute(
			"
				SELECT * FROM groups;
			"
		)
	end

	# Show the contacts_groups table
		def self.show_all_contacts_groups
		puts "This is the contacts_groups table."
		print $db.execute(
			"
				SELECT * FROM groups;
			"
		)
	end


end


# Data Validation
# come up w/ a plan to work with phone numbers (must have a valid format)
# and email addresses (must have a valid format and be unique)
# implement this plan in your code

# Driver Code
# puts Contacts.show_all_contacts				# works - shows the original seeded contacts
# puts Contacts.add_contact("Alison", "Joseph", "MHC", "123-456-789", "alisonjoseph@gmail.com")				# works
# puts Contacts.show_all_contacts				# works - Alison has been added.
# puts Contacts.show_all_groups			# works - shows the original seeded groups
# puts Contacts.add_group("MHC")			# works
# puts Contacts.show_all_groups			# works - group MHC has been added
# puts Contacts.show_all_contacts_groups		# works
# puts Contacts.change_email_add("Alison", "Joseph", "alisonrjoseph@gmail.com")		 # WORKS
# puts Contacts.show_all_contacts 		 # WORKS - ali's email has been updated
Contacts.delete_contact("Alison", "Joseph")
Contacts.show_all
# Contacts.delete_group("MHC")			 # have to code it such that you delete the dependencies in contacts_groups first. then only delete it in groups