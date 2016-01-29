require 'sqlite3'

# If you want to overwrite your database you need to delete it before running this file

$db = SQLite3::Database.new "students.db"

module StudentDB

	def self.setup
		$db.execute(
			<<-SQL
				CREATE TABLE students (
					id INTEGER PRIMARY KEY AUTOINCREMENT,
					first_name VARCHAR(64) NOT NULL,
					last_name VARCHAR(64) NOT NULL,
					gender VARCHAR(10) NOT NULL,
					birthday DATE NOT NULL,
					email VARCHAR(128) NOT NULL,
					created_at DATETIME NOT NULL,
					updated_at DATETIME NOT NULL
					);
			SQL
		)
	end

	# Add a few records to your database when you start
	def self.seed
		$db.execute(
			<<-SQL
				INSERT INTO students
					(first_name, last_name, gender, birthday, email, created_at, updated_at)
				VALUES
					('Philipp', 'Lahm', 'male', '1983-11-11', 'plahm@fcbayern.de', DATETIME('now'), DATETIME('now')),
					('Bastian', 'Schweinsteiger', 'male', '1984-08-01', 'bschweinsteiger@dfb.de', DATETIME('now'), DATETIME('now')),
					('Kelley', 'OHara', 'female', '1988-08-04', 'koh@uswnt.com', DATETIME('now'), DATETIME('now')),
					('Tobin', 'Heath', 'female', '1988-05-29', 'tph@uswnt.com', DATETIME('now'), DATETIME('now'));
			SQL
		)
	end

end

