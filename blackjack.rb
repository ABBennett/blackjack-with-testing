require_relative 'card'
require_relative 'deck'
require_relative 'hand'

require 'pry'
#!/usr/bin/env ruby


class Blackjack
  attr_accessor :dealer, :player

  def initialize
    @deck = Deck.new
    deal_starting_hands
  end

  def play
    puts "Welcome to Blackjack!"
    puts
    puts "Player was dealt #{@player.cards_in_hand[0].rank}#{@player.cards_in_hand[0].suit}"
    puts "Player was dealt #{@player.cards_in_hand[1].rank}#{@player.cards_in_hand[1].suit}"

    #ask player hit or stand
    #return calculate_score
    choice = "h"
    while choice == "h"
      puts "PLAYER SCORE: #{@player.calculate_score}"
      puts
      puts "Would you like to hit or stand?(h/s)"
      choice = gets.chomp.downcase
      if choice == "h"
        puts
        hit(@player)
        puts "Player was dealt #{@player.cards_in_hand[-1].rank}#{@player.cards_in_hand[-1].suit}"
      end

      if bust?(@player)
        puts "PLAYER SCORE: #{@player.calculate_score}"
        puts
        puts "Bust! You lose."
        choice = "b"
      end
    end
    puts

    if choice == "s"
      puts "Dealer was dealt #{@dealer.cards_in_hand[0].rank}#{@dealer.cards_in_hand[0].suit}"
      puts "Dealer was dealt #{@dealer.cards_in_hand[1].rank}#{@dealer.cards_in_hand[1].suit}"
      puts "DEALER SCORE: #{@dealer.calculate_score}"
      while @dealer.calculate_score < 17
        hit(@dealer)
        puts "Dealer was dealt #{@dealer.cards_in_hand[-1].rank}#{@dealer.cards_in_hand[-1].suit}"
        puts "DEALER SCORE: #{@dealer.calculate_score}"
        puts
      end
    end

    if bust?(@dealer)
      puts "Dealer bust!"
    else
      winning_hand
    end
    puts

  end

  def deal_starting_hands
    @player = Hand.new
    2.times { @player.cards_in_hand << @deck.deal }
    @dealer = Hand.new
    2.times { @dealer.cards_in_hand << @deck.deal }
  end

  def hit(target_hand)
    target_hand.cards_in_hand << @deck.deal
  end


  def winning_hand
    puts "Dealer stands"
    puts
    if @player.calculate_score > @dealer.calculate_score
      puts "Player wins"
    elsif @dealer.calculate_score > @player.calculate_score
      puts "Dealer wins"
    else
      puts "It's a tie."
    end


  end

  def bust?(hand)
    if hand.calculate_score > 21
      true
    else
      false
    end
  end

end

# blackjack_game = Blackjack.new
# blackjack_game.play
