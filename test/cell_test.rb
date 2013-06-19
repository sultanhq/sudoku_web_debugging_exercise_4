require 'minitest/autorun'
require '../lib/cell'

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
   
  def test_cell_can_be_solved
    @cell = Cell.new(0)
    row = slice([0,2,0,0,3,0,0,0,0])
    column = slice([0,1,5,3,6,9,0,8,2])
    box = slice([0,2,0,1,0,0,8,0,7])
    @cell.add_slice(row)
    @cell.add_slice(column)
    @cell.add_slice(box)
    @cell.solve!
    assert_equal @cell.value
  end

  def test_cell_can_be_solved
    refute @cell.solved?
    @cell.solve!
  end
end