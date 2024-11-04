require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'D:/учеба/курси softserve/ruby/homework/homework_1'

Minitest::Reporters.use! [
                           Minitest::Reporters::SpecReporter.new,
                           Minitest::Reporters::HtmlReporter.new(
                             reports_dir: 'test/reports',
                             report_filename: 'test_results_unit.html',
                             add_timestamp: true
                           )
                         ]

class TestStudent < Minitest::Test
  def setup
    Student.class_variable_set(:@@all_students, [])
    Student.add_student('Ivanov', 'Ivan', '2000-12-15')
    Student.add_student('Boshenko', 'Mark', '2001-06-20')
  end

  def test_add_student
    Student.add_student('Aliev', 'Alex', '1999-08-10') 
    assert_equal(3, Student.all_students.size) 
  end

  def test_add_duplicate_student
    assert_raises(ArgumentError) do
      Student.add_student('Ivanov', 'Ivan', '2000-12-15')
    end
  end

  def test_remove_student
    Student.remove_student('Ivanov', 'Ivan', '2000-12-15') 
    assert_equal(1, Student.all_students.size) 
  end

  def test_remove_nonexistent_student
    assert_raises(ArgumentError) do
      Student.remove_student('Wiliam', 'John', '2020-01-01')
    end
  end

  def test_calculate_age
    age = Student.calculate_age('Ivanov', 'Ivan', '2000-12-15')
    expected_age = Date.today.year - 2000 - (Date.today < Date.new(Date.today.year, 12, 15) ? 1 : 0)
    assert_equal(expected_age, age)
  end

  def test_calculate_age_for_nonexistent_student
    assert_raises(ArgumentError) do
      Student.calculate_age('Wiliam', 'John', '2020-01-01')
    end
  end

  def test_get_students_by_age
    students = Student.get_students_by_age(23)
    refute_empty(students) 
  end

  def test_get_students_by_age_no_match
    assert_raises(ArgumentError) do
      Student.get_students_by_age(100)
    end
  end

  def test_get_students_by_name
    students = Student.get_students_by_name('Mark')
    refute_empty(students) 
  end

  def test_get_students_by_name_no_match
    assert_raises(ArgumentError) do
      Student.get_students_by_name('Wiliam')
    end
  end
end
