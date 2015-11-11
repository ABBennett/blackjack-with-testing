
require_relative 'deck'
require_relative 'hand'

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def display
    print "#{@rank}#{@suit}"
  end
end
