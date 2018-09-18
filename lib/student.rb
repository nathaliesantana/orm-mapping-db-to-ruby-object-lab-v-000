require 'pry'

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    sql = <<-SQL
    SELECT * FROM students
    SQL
    binding.pry
    DB[:conn].execute(sql).map do |student_info|
      
      @id = student_info[0]
      @name = student_info[1]
      @grade= student_info[2]
     end

  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
