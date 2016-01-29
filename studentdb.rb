# Refactored to avoid SQL injections w/ Kean Ho's help.
# WORKS

require 'sqlite3'
require_relative 'setup_studentdb'

class Students

	# Add a student
	def self.add(first_name, last_name, gender, birthday, email)
		$db.execute(
			"
			INSERT INTO students
				(first_name, last_name, gender, birthday, email, created_at, updated_at)
			VALUES
				(?, ?, ?, ?, ?, DATETIME('now'), DATETIME('now'));
			",
			first_name, last_name, gender, birthday, email
		)
	puts "Added student called #{first_name} #{last_name} to the students database."
	end

	# Delete a student
	def self.delete(first_name, last_name)			# user supplies the first_name and last_name
		$db.execute(
			"
				DELETE FROM students
				WHERE first_name = ? AND last_name = ?;
			",
			first_name, last_name
		)
	puts "Deleted student called #{first_name} #{last_name} from the students database."
	end

	# Show a list of students
	def self.show_all
		puts "This is the list of students"
		print $db.execute(
			"
				SELECT * FROM students;
			"
		)
	end

	# Show a list of students with a particular first_name
	def self.show_all_first_name(first_name)
		print $db.execute(
			"
				SELECT * FROM students
				WHERE first_name = ?;
			",
			first_name
		)
		puts "These are all the students with the first name #{first_name}"
	end

	# Show a list of students with a particular attribute
	def self.show_all_with(type_of_attribute, attribute)
		case type_of_attribute
		when "first_name"
			$db.execute(
				"SELECT * FROM students WHERE first_name = ?;", attribute
			)
		when "last_name"
			$db.execute(
				"SELECT * FROM students WHERE last_name = ?;", attribute
			)
		when "gender"
			$db.execute(
				"SELECT * FROM students WHERE gender = ?;", attribute
			)
		when "birthday"
			$db.execute(
				"SELECT * FROM students WHERE birthday = ?;", attribute
			)
		when "email"
			$db.execute(
				"SELECT * FROM students WHERE email = ?;", attribute
			)
		else
			raise "Invalid Attribute."		 # to raise an error
		end
	end

end

# Driver Code
# puts Students.add("Alison", "Joseph", "female", "1993-06-22", "alisonjoseph@fcbayern.de")		# works
# puts Students.show_all  		# works
# puts Students.show_all_first_name("Alison") 			 # works
# p Students.show_all_with("gender", "male")
# Students.delete("Alison", "Joseph")		 # works
# Students.show_all  			 # works