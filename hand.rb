require_relative 'card'
require_relative 'deck'

class Hand
  attr_accessor :cards_in_hand

  def initialize
    @cards_in_hand = []
  end

  def calculate_score
    score = 0
    number_of_aces = 0
    @cards_in_hand.each do |card|
      if card.rank.is_a? Integer
        score += card.rank
      elsif ['J','Q','K'].include?(card.rank)
        score += 10
      elsif ['A'].include?(card.rank)
        number_of_aces += 1
        score += 11
      end
    end

    while score > 21
      if number_of_aces > 0
        score -= 10
        number_of_aces -= 1
      else
        break
      end
    end

    score
  end

end
