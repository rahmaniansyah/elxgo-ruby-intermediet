require "mysql2"    # if needed

@db_host  = "localhost"
@db_user  = "root"
@db_pass  = "1305438asep"
@db_name = "homework1"

#client = Mysql::Client.new(:host => @db_host, :username => @db_user, :password => @db_pass, :database => @db_name)
#@cdr_result = client.query("SELECT * from homework1; ")
=begin
CREATE TABLE `homework1`.`food` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `vegan` TINYINT NULL,
  `price` INT NULL,
  `tags` VARCHAR(100) NULL,
  PRIMARY KEY (`id`));
=end