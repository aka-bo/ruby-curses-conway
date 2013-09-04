require 'logger'

module Conway
  class Cell
    class << self
      attr_accessor :generator

      def rand_init
        seed = Random.new_seed
        @logger = Logger.new 'seeds.log'
        @logger.info "Random seed: #{seed}"
        Random.new seed
      end

      def rand_state
        return :dead if @generator.rand(100) < 60
        :live
      end
    end
    @generator = rand_init

    attr_accessor :state
    attr_accessor :neighbors

    def initialize(state = nil)
      @state = @next_state = state || Cell.rand_state
      @neighbors = []
    end

    def life_or_death
      if alive?
        evaluate_death
      else
        evaluate_birth
      end
    end

    def advance
      @state = @next_state
    end

    def alive?
      @state == :live
    end

    private

    def evaluate_death
      count = live_neighbors.size
      @next_state = :dead if count < 2 || count > 3
    end

    def evaluate_birth
      @next_state = :live if live_neighbors.size == 3
    end

    def live_neighbors
      @neighbors.select { |n| n.alive? }
    end
  end
end
