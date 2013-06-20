require_relative 'cell'
require_relative 'sudoku'
require 'sinatra/base'

module SudokuHelpers

  def get_solved_sudoku_cells(starting_puzzle_string)
    solved_sudoku = Sudoku.new(starting_puzzle_string)
    solved_sudoku.solve!
    solved_sudoku.cells
  end

  def convert_html_puzzle_to_string(values_array)
    values_array.map {|x| x == "" ? "0" : x}.join
  end

  def problem_solved?(user_sudoku, original_puzzle)    
    sudoku_puzzle = Sudoku.new(original_puzzle)
    sudoku_puzzle.solve!
    sudoku_puzzle.to_s == user_sudoku
  end

  def end_of_row?(index)
    (index % 9 == 0) && (index != 0)
  end

  def cells_criteria
    @solved_cells = get_solved_sudoku_cells(session[:set_sudoku])
    @starting_cells = Sudoku.new(session[:set_sudoku]).cells
    @cells = Sudoku.new(session[:current_sudoku]).cells
  end

  def difficulty_level(session_sudoku_string)
    session_sudoku_string.count("0") >= 54 ? "Hard" : "Easy"
  end

  def words_of_encouragement(current_puzzle_state, original_puzzle)
    if problem_solved?(current_puzzle_state, original_puzzle)
      "Problem solved!"
    else
      [ "Keep trying.",
        "You're nearly there",
        "Almost, but not quite.",
        "Nah. You're just guessing now.",
        "Don't give up.",
        "You can do it."
      ].sample
    end
  end

end

