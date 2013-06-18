require './lib/sudoku'
require 'sinatra'

post '/' do
  cell_values = params[:cells] # extract the cell values from the params hash
  puzzle_string = cell_values.join # convert to a string
  sudoku = Sudoku.new(puzzle_string) # create new instance of model class
  @message = sudoku.solve? ? "You won" : "You lost"
  erb :home
end