# require 'bundler'
# Bundler.require

# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# require_all 'lib'

require 'bundler'
Bundler.require

# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.rb')
 require_all 'lib'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
old_logger = ActiveRecord::Base::logger
ActiveRecord::Base.logger = nil