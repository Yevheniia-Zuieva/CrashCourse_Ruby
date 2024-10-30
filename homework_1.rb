require 'date'

class Student
	attr_accessor :surname, :name, :date_of_birth
	@@all_students = []

	def initialize(surname, name, date_of_birth)
		@surname = surname
		@name = name
		@date_of_birth = date_of_birth
		@@all_students<<self
	end

	def self.all_students
		@@all_students
	end

	def self.add_student
		print('Enter surname: ')
		surname = gets.chomp
		print('Enter name: ')
		name = gets.chomp
		print('Enter date of birth (YYYY-MM-DD): ')
		input_date_of_birth = gets.chomp
		
		begin
			date_of_birth = Date.parse(input_date_of_birth)
			if date_of_birth > Date.today
				raise ArgumentError, "The date of birth cannot in the fiture: #{date_of_birth}."
			end

			if @@all_students.any? { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
				raise ArgumentError, "Record with data sumane = #{surname}, name = #{name}, date_of_birth = #{date_of_birth} already exists."
			end

			Student.new(surname, name, date_of_birth)
			puts "Record:  #{surname}, name = #{name}, date_of_birth = #{date_of_birth} successfully added"
		rescue ArgumentError => e
			puts "Error: #{e.message}"
		end
	end


	def self.remove_student
		print('Enter surname to remove: ')
		surname = gets.chomp
		print('Enter name to remove: ')
		name = gets.chomp
		print('Enter date of birth to remove (YYYY-MM-DD): ')
		input_date_of_birth = gets.chomp
		
		begin
			date_of_birth = Date.parse(input_date_of_birth)
			student_to_remove = @@all_students.find { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
			if student_to_remove
				@@all_students.delete(student_to_remove)
				puts "Student #{surname}, name = #{name}, date_of_birth = #{date_of_birth} has been removed"
			else
				raise ArgumentError, "No student found with surname = #{surname}, name = #{name}, date_of_birth = #{date_of_birth}"
			end
		rescue ArgumentError => e
			puts "Error: #{e.message}"
		end
	end

	def self.calculate_age
    print('Enter surname to calculate age: ')
    surname = gets.chomp
    print('Enter name to calculate age: ')
    name = gets.chomp
    print('Enter date of birth to calculate age (YYYY-MM-DD): ')
    input_date_of_birth = gets.chomp

    begin
        date_of_birth = Date.parse(input_date_of_birth)
     	student_to_calculate = @@all_students.find { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
	      	if student_to_calculate
	        	age = Date.today.year - date_of_birth.year
	        	age -= 1 if Date.today < Date.new(Date.today.year, date_of_birth.month, date_of_birth.day)
	        	puts "Student #{surname}, name = #{name}, date_of_birth = #{date_of_birth} is #{age} years old"
	     	else
	        	raise ArgumentError, "No student found with surname = #{surname}, name = #{name}, date_of_birth = #{date_of_birth}"
	      	end
	    rescue ArgumentError => e
	      	puts "Error: #{e.message}"
	    end
	end

	def self.get_students_by_age (age)
		begin
			student_search_by_age = @@all_students.select do |student|
				student_age = Date.today.year - student.date_of_birth.year
				student_age -= 1 if Date.today < Date.new(Date.today.year, student.date_of_birth.month, student.date_of_birth.day)
				student_age == age
			end
			if student_search_by_age.size > 0
				puts "Student #{age} years old: "
				student_search_by_age.each { |student| puts "Student #{student.surname}, name = #{student.name}, date_of_birth = #{student.date_of_birth}" }
			else
				raise ArgumentError, "No people with this age were found"
			end
		rescue ArgumentError => e
	      	puts "Error: #{e.message}"
		end
	end

	def self.get_students_by_name (input_name)
		begin
			student_search_by_name = @@all_students.select do |student|
				student_name = student.name
				student_name == input_name
			end
			if student_search_by_name.size > 0
				puts "Student #{input_name}: "
				student_search_by_name.each { |student| puts "Student #{student.surname}, name = #{student.name}, date_of_birth = #{student.date_of_birth}" }
			else
				raise ArgumentError, "No people with this name were found"
			end
		rescue ArgumentError => e
	      	puts "Error: #{e.message}"
		end
	end
end

begin
	print('Enter information about the number of students you want to add: ')
	number = gets.chomp.to_i
	
	if number <= 0
		raise ArgumentError, "The number must be greater than 0"
	end

	i = 0
	while i < number
		Student.add_student
		i += 1
	end
	puts "All student added: #{Student.all_students.inspect}"

	print('Do you want to remove a student? (yes/no): ')
	answer = gets.chomp
	if answer == 'yes'
		Student.remove_student
	elsif answer == 'no'
		print('Okey :)')
	else
		raise ArgumentError, "Wrong values are entered"
	end

	Student.calculate_age

	print('Enter the age of the student: ')
	age = gets.chomp.to_i
	Student.get_students_by_age(age)

	print('Enter the name of the student you want to find: ')
	input_name = gets.chomp
	Student.get_students_by_name(input_name)
rescue ArgumentError => e
	puts "Error: #{e.message}"
end
