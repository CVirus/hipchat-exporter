require 'erb'
require 'yaml'

namespace :db do
  if ActiveRecord::Base.connected?
    ActiveRecord::Base.connection_pool.disconnect!
  end

  db_config_path = File.join(HipChatExporter::ROOT_PATH, 'config/database.yml')
  db_config = YAML.load(ERB.new(File.read(db_config_path)).result)[ENV['ENV'] || 'default']

  desc "Create the database"
  task :create do
    database_task = ActiveRecord::Tasks::MySQLDatabaseTasks.new(db_config)
    database_task.create
    puts "Database #{db_config['database']} created"
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Migrator.migrate('db/migrate/')
    Rake::Task['db:schema'].invoke
    puts "Database #{db_config['database']} migrated"
  end

  desc "Rollback the database"
  task :rollback do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Migrator.rollback('db/migrate/')
    Rake::Task['db:schema'].invoke
    puts "Database #{db_config['database']} rollbacked"
  end

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require 'active_record/schema_dumper'
    schema_path = File.join(HipChatExporter::ROOT_PATH, 'db/schema.rb')
    File.open(schema_path, 'w:utf-8') do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end

  desc "Drop the database"
  task :drop do
    database_task = ActiveRecord::Tasks::MySQLDatabaseTasks.new(db_config)
    database_task.drop
    puts "Database #{db_config['database']} deleted"
  end
end
