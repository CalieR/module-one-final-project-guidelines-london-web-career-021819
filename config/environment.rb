require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = false


require_all 'app'
require_all 'bin/methods.rb'
require 'tty-prompt'
require 'faker'
