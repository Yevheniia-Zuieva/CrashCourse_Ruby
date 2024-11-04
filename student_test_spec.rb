require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require_relative 'D:/учеба/курси softserve/ruby/homework/homework_1'

Minitest::Reporters.use! [
  Minitest::Reporters::SpecReporter.new,
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'test/reports_2',
    report_filename: 'test_results_spec.html',
    add_timestamp: true
  )
]

describe Student do
  before do
    Student.class_variable_set(:@@all_students, [])
    Student.add_student('Ivanov', 'Ivan', '2000-12-15')
    Student.add_student('Boshenko', 'Mark', '2001-06-20')
  end

  it 'adds a student successfully' do
    Student.add_student('Aliev', 'Alex', '1999-08-10')
    _(Student.all_students.size).must_equal 3
  end

  it 'raises an error when adding a duplicate student' do
    proc {
      Student.add_student('Ivanov', 'Ivan', '2000-12-15')
    }.must_raise ArgumentError
  end

  describe '.remove_student' do
    it 'removes an existing student' do
      Student.remove_student('Ivanov', 'Ivan', '2000-12-15')
      _(Student.all_students.size).must_equal 1
    end

    it 'raises an error when trying to remove a nonexistent student' do
      proc {
        Student.remove_student('Wiliam', 'John', '2020-01-01')
      }.must_raise ArgumentError
    end
  end

  describe '.calculate_age' do
    it 'calculates the correct age' do
      age = Student.calculate_age('Ivanov', 'Ivan', '2000-12-15')
      expected_age = Date.today.year - 2000 - (Date.today < Date.new(Date.today.year, 12, 15) ? 1 : 0)
      _(age).must_equal expected_age
    end

    it 'raises an error for a nonexistent student' do
      proc {
        Student.calculate_age('Wiliam', 'John', '2020-01-01')
      }.must_raise ArgumentError
    end
  end

  describe '.get_students_by_age' do
    it 'returns students of a specific age' do
      students = Student.get_students_by_age(23)
      _(students).wont_be_empty
    end

    it 'raises an error when no students match the age' do
      proc {
        Student.get_students_by_age(100)
      }.must_raise ArgumentError
    end
  end

  describe '.get_students_by_name' do
    it 'returns students with the specified name' do
      students = Student.get_students_by_name('Mark')
      _(students).wont_be_empty
    end

    it 'raises an error when no students match the name' do
      proc {
        Student.get_students_by_name('Wiliam')
      }.must_raise ArgumentError
    end
  end
end
