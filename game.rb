require './lib/sudoku'
require 'sinatra'

configure do
  enable :sessions
end

post '/' do
  cell_values = params[:cells] # extract the cell values from the params hash
  puzzle_string = cell_values.map {|x| x == " " ? "0" : x}.join # convert to a string
  sudoku = Sudoku.new(puzzle_string) # create new instance of model class
  @message = sudoku.solved? ? "You won" : "You lost"
  @cells = sudoku.cells
  erb :home
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
