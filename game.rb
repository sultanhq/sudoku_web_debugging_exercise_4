require './lib/sudoku'
require 'sinatra'
require 'sinatra/flash'


configure do
  use Rack::Session::Cookie, :key => 'rack.session',
                              :path => '/',
                              :expire_after => 2592000, # In seconds
                              :secret => 'I am the secret code to encrypt the cookie'  
end

class SudokuWeb < Sinatra::Application

  post '/' do  
    puzzle_string = convert_values_array_to_string(params[:cells])
    flash[:info] = problem_solved?(puzzle_string) ? "You won" : "You lost"
    update_current_sudoku_cookie(puzzle_string)
    redirect to('/')
  end

  get '/' do
    if session[:current_sudoku]
      sudoku_puzzle = Sudoku.new(session[:current_sudoku])
    else
      sudoku_puzzle = Sudoku.generate
      session[:sudoku_string] = sudoku_puzzle.to_s
      session[:current_sudoku] = sudoku_puzzle.to_s
    end
    @cells = sudoku_puzzle.cells
    erb :home
  end

  get '/new' do
    session.clear
    redirect to('/')
  end

  def problem_solved?(puzzle_string)
    sudoku_puzzle = Sudoku.new(puzzle_string) # create new instance of sudoku with the current string
    sudoku_puzzle.solved?
  end

  def update_current_sudoku_cookie(puzzle_string)
    session[:current_sudoku] = puzzle_string
  end

  def convert_values_array_to_string(values_array)
    values_array.map {|x| x == "" ? "0" : x}.join # convert to a string
  end

end