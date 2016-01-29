require 'sqlite3'

# If you want to overwrite your database you need to delete it before running this file
$db = SQLite3::Database.new "address_book.db"

module AddressBook

	def self.setup_contacts
		$db.execute(
			<<-SQL
				CREATE TABLE contacts (
					id INTEGER PRIMARY KEY AUTOINCREMENT,
					first_name VARCHAR(64) NOT NULL,
					last_name VARCHAR(64) NOT NULL,
					company VARCHAR(128) NOT NULL,
					phone_number VARCHAR(64) NOT NULL,
					email_address VARCHAR(128) NOT NULL,
					created_at DATETIME NOT NULL,
					updated_at DATETIME NOT NULL
					);
			SQL
		)
	end

	def self.setup_groups
		$db.execute(
			<<-SQL
				CREATE TABLE groups (
					id INTEGER PRIMARY KEY AUTOINCREMENT,
					group_name VARCHAR(128) NOT NULL,
					created_at DATETIME NOT NULL,
					updated_at DATETIME NOT NULL
					);
			SQL
		)
	end

	def self.setup_contacts_groups
		$db.execute(
			<<-SQL
				CREATE TABLE contacts_groups (
					id INTEGER PRIMARY KEY AUTOINCREMENT,
					contact_id INTEGER NOT NULL,
					group_id INTEGER NOT NULL,
					FOREIGN KEY (contact_id) REFERENCES contacts(id),
					FOREIGN KEY (group_id) REFERENCES groups(id)
					);
			SQL
		)
	end

	# Add a few records to your database when you start
	def self.seed_contacts
		$db.execute(
			<<-SQL
				INSERT INTO contacts
					(first_name, last_name, company, phone_number, email_address, created_at, updated_at)
				VALUES
					('Philipp', 'Lahm', 'Bayern Munich', '2121-1616', 'plahm@fcbayern.de', DATETIME('now'), DATETIME('now')),
					('Bastian', 'Schweinsteiger', 'DFB', '3131-0707', 'bschweinsteiger@dfb.de', DATETIME('now'), DATETIME('now')),
					('Mario', 'Götze', 'Bayern Munich', '1919-1919', 'mgoetze@fcbayern.de', DATETIME('now'), DATETIME('now')),
					('Javi', 'Martinez', 'Bayern Munich', '0808-0404', 'jmartinez@fcbayern.de', DATETIME('now'), DATETIME('now'))
			SQL
		)
	end

	def self.seed_groups
		$db.execute(
			<<-SQL
				INSERT INTO groups
					(group_name, created_at, updated_at)
				VALUES
					('German NT', DATETIME('now'), DATETIME('now')),
					('Spain NT', DATETIME('now'), DATETIME('now')),
					('Bayern Munich', DATETIME('now'), DATETIME('now'))
			SQL
		)
	end

	def self.seed_contacts_groups
		$db.execute(
			<<-SQL
				INSERT INTO contacts_groups
					(contact_id, group_id)
				VALUES
					("1", "3"),
					("2", "1"),
					("3", "1"),
					("3", "3"),
					("4", "2"),
					("4", "3")
			SQL
		)
	end

end

