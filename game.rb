#!/usr/bin/env ruby

require 'curses'
require_relative 'grid'
require_relative 'conway'

class GameOfLife
  CELL_SIZE = 4

  def initialize
    Curses.init_screen
    Curses.timeout = 20
    Curses.crmode
    Curses.curs_set 0
    Curses.noecho
    Curses.start_color

    Curses.init_pair(Curses::COLOR_BLACK, Curses::COLOR_BLACK, Curses::COLOR_BLACK)
    Curses.init_pair(Curses::COLOR_BLUE, Curses::COLOR_BLACK, Curses::COLOR_BLUE)
  end

  def play
    show_message("Hit Any Key. (Interrupt to exit)")

    column_count = (Curses.cols-2)/CELL_SIZE
    row_count = (Curses.lines-2)/2
    grid = Grid.new column_count, row_count

    until Curses.getch
      draw grid
    end

    Curses.clear
    Curses.refresh
  end

  private

  def show_message(message)
    padding = 6
    width = message.length + padding
    win = Curses::Window.new(5, width, (Curses.lines - 5)/2, (Curses.cols - width)/2)
    win.box '|', '-'
    win.setpos 2, 3
    win.addstr message

    win.getch
    win.close
  end

  def draw(grid)
    start = Time.now
    grid.tick

    Curses.doupdate

    win = Curses::Window.new Curses.lines, Curses.cols, 0, 0
    win.box '|', '-'

    grid.each_cell do |c|
      add_cell(win, c[:x], c[:y]) if c[:cell].alive?
    end

    win.refresh

    delta = Time.now - start
    nap_time = 1/6.0 - delta
    sleep(nap_time) if nap_time > 0
  rescue Interrupt
    exit
  ensure
    win.close if win
  end

  def add_cell(win, x, y)
    top = y*2 + 1
    left = ((x+1)*CELL_SIZE - 2)
    sw = win.subwin 2, CELL_SIZE, top, left
    color = Curses.color_pair Curses::COLOR_BLUE
    sw.attron(color|Curses::A_NORMAL) {
      sw.box " ", " ", " "
    }

    Curses.doupdate
  end
end

if __FILE__ == $0
  game = GameOfLife.new
  loop { game.play }
end
