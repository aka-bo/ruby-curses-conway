require 'logger'
require_relative 'conway'

class Grid
  include Conway

  attr_accessor :cells

  def initialize(cols, rows)
    @logger = Logger.new('logfile.log')
    @column_count = cols
    @row_count = rows

    generate_cells
    assign_neighbors
  end

  def tick
    @all_cells.each {|c| c.life_or_death}
    @all_cells.each {|c| c.advance}
  end

  def each_cell
    (0...@row_count).each do |y|
      (0...@column_count).each do |x|
        yield :y => y, :x => x, :cell => @cells[y][x]
      end
    end
  end

  private

  def generate_cells
    @cells = []

    (0...@row_count).each do |y|
      @cells[y] = []
      (0...@column_count).each do |x|
        @cells[y][x] = Conway::Cell.new
      end
    end

    @all_cells = @cells.flatten
  end

  def assign_neighbors
    (0...@row_count).each do |y|
      (0...@column_count).each do |x|
        cell = @cells[y][x]

        rb = @column_count-1

        if y > 0
          cell.neighbors.push @cells[y-1][x-1] if x > 0
          cell.neighbors.push @cells[y-1][x]
          cell.neighbors.push @cells[y-1][x+1] if x < rb
        end

        if x > 0
          cell.neighbors.push @cells[y][x-1]
        end

        if x < rb
          cell.neighbors.push @cells[y][x+1]
        end

        if y < @row_count-1
          cell.neighbors.push @cells[y+1][x-1] if x > 0
          cell.neighbors.push @cells[y+1][x]
          cell.neighbors.push @cells[y+1][x+1] if x < rb
        end
      end
    end
  end

  def lookup(y,x)
    @cells[y][x]
  end
end
