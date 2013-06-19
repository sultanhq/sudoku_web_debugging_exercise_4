require_relative 'cell'
require_relative 'sudoku'


module HelperMethods

  def get_solved_sudoku_cells(starting_puzzle_string)
    solved_sudoku = Sudoku.new(starting_puzzle_string)
    solved_sudoku.solve!
    solved_sudoku.cells
  end

  def problem_solved?(user_sudoku, original_puzzle)    
    sudoku_puzzle = Sudoku.new(original_puzzle) # create new instance of sudoku with the current string
    sudoku_puzzle.solve!
    sudoku_puzzle.to_s == user_sudoku
  end

  def convert_values_array_to_string(values_array)
    values_array.map {|x| x == "" ? "0" : x}.join # convert to a string
  end

end