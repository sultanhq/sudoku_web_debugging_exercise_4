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
    flash[:info] = problem_solved?(params[:cells]) ? "You won" : "You lost"
    update_current_sudoku_cookie(params[:cells])
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

  def problem_solved?(cell_values)
    puzzle_string = cell_values.map {|x| x == "" ? "0" : x}.join # convert to a string
    sudoku_puzzle = Sudoku.new(puzzle_string) # create new instance of sudoku with the current string
    sudoku_puzzle.solved?
  end

  def update_current_sudoku_cookie(cell_values)
    sudoku_puzzle = Sudoku.new(cell_values)
    session[:current_sudoku] = sudoku_puzzle.to_s
  end

end