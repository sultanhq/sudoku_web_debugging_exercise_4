require_relative '../game'
require 'minitest/autorun'
require 'rack/test'

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

end