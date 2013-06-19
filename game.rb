require './lib/sudoku'
require 'sinatra'
require 'sinatra/flash'


configure do
  enable :sessions
end

class SudokuWeb < Sinatra::Application

  post '/' do
    cell_values = params[:cells] # extract the cell values from the params hash
    puzzle_string = cell_values.map {|x| x == "" ? "0" : x}.join # convert to a string
    sudoku_puzzle = Sudoku.new(puzzle_string) # create new instance of model class
    flash[:info] = sudoku_puzzle.solved? ? "You won" : "You lost"
    @cells = sudoku_puzzle.cells
    # session[:sudoku_string] = sudoku_puzzle.to_s
    redirect to('/')
  end

  get '/' do
    if session[:sudoku_string]
      sudoku_puzzle = Sudoku.new(session[:sudoku_string])
    else
      sudoku_puzzle = Sudoku.generate
      session[:sudoku_string] = sudoku_puzzle.to_s
    end
    @cells = sudoku_puzzle.cells
    erb :home
  end

  get '/new' do
    session.clear
    redirect to('/')
  end

end