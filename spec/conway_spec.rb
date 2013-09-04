require_relative '../conway'

include Conway

describe "Game of Life" do
  describe "cells" do
    before :each do
      @cell = Cell.new :live
    end

    def live_cell
      Cell.new :live
    end

    it "has a state" do
      expect(@cell.state).to_not be_nil
    end

    it "has neighbors" do
      expect(@cell.neighbors).to_not be_nil
    end

    describe "rule evaluations" do
      it "evaluates rules" do
        @cell.life_or_death
      end

      it "doesn't affect cell state until #advance is executed" do
        @cell.life_or_death
        expect(@cell.state).to eq :live

        @cell.advance
        expect(@cell.state).to eq :dead
      end

      it "marked for death if fewer than 2 live neighbors" do
        @cell.life_or_death
        @cell.advance
        expect(@cell.state).to eq :dead
      end

      it "remains alive if 2 or 3 neighbors are alive" do
        @cell.neighbors = [live_cell]*2
        @cell.life_or_death
        @cell.advance
        expect(@cell.state).to eq :live
      end

      it "dies if more than 3 neighbors are alive" do
        @cell.neighbors = [live_cell]*4
        @cell.life_or_death
        @cell.advance
        expect(@cell.state).to eq :dead
      end

      it "resurrects dead cells if exactly 3 neighbors are alive" do
        @cell.state = :dead
        @cell.neighbors = [live_cell]*3
        @cell.life_or_death
        @cell.advance
        expect(@cell.state).to eq :live
      end
    end
  end
end
