require_relative '../lib/sudoku_helpers'
require 'minitest'
require 'minitest/autorun'
require 'ostruct'


class  TestHelperMethods < Minitest::Test
include SudokuHelpers

  def setup
    @puzzle_string = '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
    @solved_puzzle = '615493872348127956279568431496832517521746389783915264952681743864379125137254698'
  end

  def test_get_solved_sudoku_cells
    cells = get_solved_sudoku_cells(@puzzle_string)
    assert_equal 81, cells.count
    assert cells.all?{|c| c.solved?}
  end

  def test_problem_solved?
    refute problem_solved?(@puzzle_string, @solved_puzzle)
    assert problem_solved?(@solved_puzzle, @solved_puzzle)
  end

  def convert_html_puzzle_to_string
    string = "1234567"
    array = ["1","2","3","4","5","6","7"]
    assert_equal string, convert_html_puzzle_to_string(array)
  end

  def test_end_of_row
    refute end_of_row?(0)
    assert end_of_row?(9)
    assert end_of_row?(18)
    refute end_of_row?(10)
  end

  def test_difficulty_level
    sudoku_string = '123000000123000000123000000123000000123000000123000000123000000123000000123000000'
    assert_equal "Hard",  difficulty_level(sudoku_string)
  end

  def test_words_of_encouragement
    assert_equal "Problem solved!", words_of_encouragement(@solved_puzzle, @puzzle_string) # response to solved
    assert_kind_of String, words_of_encouragement(@puzzle_string, @puzzle_string)          # response to unsolved
    refute_equal "Problem solved!", words_of_encouragement(@puzzle_string, @puzzle_string) # response to unsolved
  end

end