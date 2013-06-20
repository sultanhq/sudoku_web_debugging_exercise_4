require_relative '../game'
require 'minitest'
require 'minitest/autorun'
require 'rack/test'
require_relative '../lib/sudoku'

set :environment, :test

# more about testing: http://www.sinatrarb.com/testing.html

class SudokuWebTest < Minitest::Test

  def setup
    @browser = Rack::Test::Session.new(Rack::MockSession.new(SudokuWeb))
  end

  def test_it_shows_the_homepage
    @browser.get '/'
    assert @browser.last_response.ok?
    assert @browser.last_response.body.include? "Life is too short for playing Sudoku"
  end

  def test_it_new_easy_game_button_works
    @browser.get '/new'
    @browser.follow_redirect!
    assert_equal 'http://example.org/', @browser.last_request.url
    assert @browser.last_response.body.include? "Life is too short for playing Sudoku"
  end

  def test_it_new_hard_game_button_works
    @browser.get '/hard'
    assert @browser.last_response.body.include? "Life is too short for playing Sudoku"
  end

end