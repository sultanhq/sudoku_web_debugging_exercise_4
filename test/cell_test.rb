require 'minitest'
require 'minitest/autorun'
require_relative '../lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new(0)
    row = slice([8,0,0,0,0,0,0,0,0])
    column = slice([8,0,0,0,0,0,0,0,0])
    box = slice([8,0,0,0,0,3,0,7,0])
    @cell.add_slice(row)
    @cell.add_slice(column)
    @cell.add_slice(box)
  end

  def slice(array)
    @cell = Cell.new(0)
    array.map {|v| Cell.new(v)}
  end
   
  def test_cell_can_have_a_value
    cell = Cell.new(5)
    assert_equal 5, cell.value
  end

  def test_cell_is_solved_if_it_has_a_value
    cell = Cell.new(5)
    assert cell.solved?
  end

  def test_cell_is_solved_if_it_has_no_value
    cell = Cell.new(0)
    refute cell.solved?
  end

  def test_cell_can_find_its_value
    @cell = Cell.new(0)
    row = slice([0,2,0,0,3,0,0,0,0])
    column = slice([0,1,5,3,6,9,0,8,2])
    box = slice([0,2,0,1,0,0,8,0,7])
    @cell.add_slice(row)
    @cell.add_slice(column)
    @cell.add_slice(box)
    @cell.solve!
    assert_equal 4, @cell.value
  end

end