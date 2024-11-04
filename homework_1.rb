require 'date'

class Student
  attr_accessor :surname, :name, :date_of_birth
  @@all_students = []

  def initialize(surname, name, date_of_birth)
    date_of_birth = Date.parse(date_of_birth) if date_of_birth.is_a?(String)
    raise ArgumentError, "The date of birth cannot be in the future: #{date_of_birth}." if date_of_birth > Date.today

    @surname = surname
    @name = name
    @date_of_birth = date_of_birth
    @@all_students << self
    
  end

  def self.all_students
    @@all_students
  end

  def self.add_student(surname, name, date_of_birth)
    date_of_birth = Date.parse(date_of_birth) if date_of_birth.is_a?(String)
    if @@all_students.any? { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
      raise ArgumentError, "Record with surname = #{surname}, name = #{name}, date_of_birth = #{date_of_birth} already exists."
    end

    Student.new(surname, name, date_of_birth)
  end

  def self.remove_student(surname, name, date_of_birth)
    date_of_birth = Date.parse(date_of_birth) if date_of_birth.is_a?(String)
    student_to_remove = @@all_students.find { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
    raise ArgumentError, "No student found with surname = #{surname}, name = #{name}, date_of_birth = #{date_of_birth}" unless student_to_remove

    @@all_students.delete(student_to_remove)
  end

  def self.calculate_age(surname, name, date_of_birth)
    date_of_birth = Date.parse(date_of_birth) if date_of_birth.is_a?(String)
    student_to_calculate = @@all_students.find { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
    raise ArgumentError, "No student found with surname = #{surname}, name = #{name}, date_of_birth = #{date_of_birth}" unless student_to_calculate

    age = Date.today.year - student_to_calculate.date_of_birth.year
    age -= 1 if Date.today < Date.new(Date.today.year, student_to_calculate.date_of_birth.month, student_to_calculate.date_of_birth.day)
    age
  end

  def self.get_students_by_age(age)
    student_search_by_age = @@all_students.select do |student|
      student_age = Date.today.year - student.date_of_birth.year
      student_age -= 1 if Date.today < Date.new(Date.today.year, student.date_of_birth.month, student.date_of_birth.day)
      student_age == age
    end
    raise ArgumentError, "No people with this age were found" if student_search_by_age.empty?

    student_search_by_age
  end

  def self.get_students_by_name(input_name)
    student_search_by_name = @@all_students.select do |student|
      student.name == input_name
    end
    raise ArgumentError, "No people with this name were found" if student_search_by_name.empty?

    student_search_by_name
  end
end

Student.add_student('Ivanov', 'Ivan', '2000-12-15')
Student.add_student('Boshenko', 'Mark', '2001-06-20')
Student.add_student('Aliev', 'Alex', '1999-08-10')

Student.remove_student('Boshenko', 'Mark', '2001-06-20')

age_of_student = Student.calculate_age('Ivanov', 'Ivan', '2000-12-15')

students_by_age = Student.get_students_by_age(23)

students_by_name = Student.get_students_by_name('Alex')
