require '../lib/helper_methods'
require 'minitest'
require 'minitest/autorun'

class HelperMethodsClass
  include Sinatra::HelperMethods
end

class  TestHelperMethods < Minitest::Test

  def setup
    @helper_methods_class_instance = HelperMethodsClass.new
    @puzzle_string = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
    @solved_puzzle = '615493872348127956279568431496832517521746389783915264952681743864379125137254698'
  end

  def test_get_solved_sudoku_cells
    cells = @helper_methods_class_instance.get_solved_sudoku_cells(@puzzle_string)
    assert_equal 81, cells.count
    assert cells.all?{|c| c.solved?}
  end

  def test_problem_solved?
    refute @helper_methods_class_instance.problem_solved?(@puzzle_string, @solved_puzzle)
    assert @helper_methods_class_instance.problem_solved?(@solved_puzzle, @solved_puzzle)
  end

  def test_convert_values_array_to_string
    string = "1234567"
    array = ["1","2","3","4","5","6","7"]
    assert_equal string, @helper_methods_class_instance.convert_values_array_to_string(array)
  end

end