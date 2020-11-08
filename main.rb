require 'yaml'
require 'pg'
require "active_record"
require 'byebug'

db_config = YAML::load(File.open('database.yml'))

ActiveRecord::Base.establish_connection(db_config['default'])
ActiveRecord::Base.connection.create_database(db_config['development']['database'])
ActiveRecord::MigrationContext.new("db/migrate/", ActiveRecord::SchemaMigration)

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class User < ApplicationRecord
end
