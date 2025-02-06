require 'sinatra'
require 'sqlite3'

# Create a new SQLite database (or open it if it already exists)
db = SQLite3::Database.new 'submissions.db'

# Create a table to store the submissions if it doesn't already exist
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS submissions (
    id INTEGER PRIMARY KEY,
    name TEXT,
    website TEXT
  );
SQL

# Route to handle form submissions
post '/submit' do
  name = params[:name]
  website = params[:website]

  # Insert the submitted data into the database
  db.execute 'INSERT INTO submissions (name, website) VALUES (?, ?)', [name, website]

  "Submission received: Name - #{name}, Website - #{website}"
end
