require_relative 'cell'

class Sudoku
  
  COLUMN_SIZE = 9
  SIZE = COLUMN_SIZE * COLUMN_SIZE
  BOX_SIZE = Math.sqrt(COLUMN_SIZE)

  attr_reader :cells
  # private :cells

  def initialize(args)
    raise "Wrong number of values given, #{SIZE} expected" unless args.length == SIZE
    initialize_cells(args)
     # @cells = args.split('').map {|v| Cell.new(v) }
  end

  def self.generate
     puzzle = Sudoku.new '800000000003600000070090200050007000000045700000100030001000068008500010090000400'
     puzzle.cells
  end

  def to_s
    @cells.map(&:value).join
  end

  def to_board
    # this is arguably stupid
    rows = @cells.each_slice(COLUMN_SIZE).inject([]) do |strings, row|
      strings << row.each_slice(BOX_SIZE).map{|a| a.map(&:to_s).join(" ")}.join(" | ")
    end
    row_length = rows.first.length    
    separator = "\n#{'-' * row_length}\n"
    rows.each_slice(BOX_SIZE).map{|s| s.join("\n")}.join(separator)
  end

  def solved?
    @cells.all? {|cell| cell.solved? }
  end

  def solve!        
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      try_to_solve!
      outstanding         = @cells.count {|c| c.solved? }
      looping             = outstanding_before == outstanding
      outstanding_before  = outstanding
    end
    try_harder unless solved?
  end

private

  def replicate!
    self.class.new(self.to_s)
  end

  def steal_solution(source)
    initialize_cells(source.to_s)        
  end

  def try_harder
    blank_cell = @cells.reject(&:solved?).first
    blank_cell.candidates.each do |candidate|
      blank_cell.assume(candidate)
      board = replicate!
      board.solve!
      steal_solution(board) and return if board.solved?
    end
  end

  def try_to_solve!
    @cells.each do |cell|        
      cell.solve! unless cell.solved?                
    end      
  end

  def rows(cells)
    (0..COLUMN_SIZE-1).inject([]) do |rows, index|
      rows << cells.slice(index * COLUMN_SIZE, COLUMN_SIZE)
    end
  end

  def columns(cells, rows)
    (0..COLUMN_SIZE-1).inject([]) do |cols, index|
      cols << rows.map{|row| row[index]}
    end
  end

  def boxes(rows)    
    (0..BOX_SIZE-1).inject([]) do |boxes, i|
      relevant_rows = rows.slice(BOX_SIZE * i, BOX_SIZE)
      boxes + relevant_rows.transpose.each_slice(BOX_SIZE).map(&:flatten)       
    end        
  end
  
  def initialize_cells(digits)
    cells       = digits.split('').map {|v| Cell.new(v) }    
    rows        = rows(cells)
    columns     = columns(cells, rows)
    boxes       = boxes(rows)
    [columns, rows, boxes].each do |slices|
      slices.each {|group| group.each{|cell| cell.add_slice(group)}}
    end
    @cells = cells
  end


end

# class Sudoku

#   attr_reader :cells

#   SIZE = 81
#   COLUMN_SIZE = 9
#   BOX_SIZE = 3


#   def initialize(args)
#     raise "Wrong number of values given, #{SIZE} expected" unless args.length == SIZE
#     @cells = args.split('').map {|v| Cell.new(v) }
#   end

#   def self.generate
#     puzzle = Sudoku.new '015003002000100906270068430490002017501040380003905000900081040860070025037204600'
#     puzzle.cells
#   end

#   def solve!
#     while not solved? do
#       @cells.each_with_index do |cell, i|
#         cell.update!(common_row(i), common_column(i), common_box(i))
#       end
#     end
#   end

#   def common_row(index)
#     # integer division here
#     from = index - index % COLUMN_SIZE
#     @cells.slice(from, COLUMN_SIZE)
#   end

#   def common_column(index)
#     initial = index % COLUMN_SIZE
#     Array.new(COLUMN_SIZE).map {
#       cell = @cells[initial]
#       initial += COLUMN_SIZE
#       cell
#     }
#   end

#   def common_box(index)
#     # integer division here, possibly suboptimal
#     initial = (index % COLUMN_SIZE)  + index/COLUMN_SIZE / BOX_SIZE * COLUMN_SIZE * BOX_SIZE
#     Array.new(BOX_SIZE) {
#       cells = @cells.slice(initial, BOX_SIZE)
#       initial += COLUMN_SIZE
#       cells
#     }.flatten
#   end

#   def solved?
#     @cells.all? {|cell| cell.solved? }
#   end

#   def to_s
#     @cells.map(&:value).join
#   end

# end