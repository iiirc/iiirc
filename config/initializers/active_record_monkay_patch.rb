raise "Remove this monkey patch" if ActiveRecord::VERSION::STRING >= "4.1.0"
ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::NATIVE_DATABASE_TYPES[:primary_key] = "int(11) auto_increment PRIMARY KEY"
