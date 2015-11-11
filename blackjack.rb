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
    display_card(@player,0)
    display_card(@player,1)

    choice = "h"
    while choice == "h"
      puts "\nPLAYER SCORE: #{@player.calculate_score}"
      puts
      puts "Would you like to hit or stand?(h/s)"
      choice = gets.chomp.downcase
      if choice == "h"
        puts
        hit(@player)
        display_card(@player, -1)

      end

      if bust?(@player)
        puts "\nPLAYER SCORE: #{@player.calculate_score}"
        puts
        puts "Bust! You lose."
        choice = "b"
      end
    end
    puts

    if choice == "s"
      display_card(@dealer,0)
      display_card(@dealer,1)
      puts "\nDEALER SCORE: #{@dealer.calculate_score}"
      while @dealer.calculate_score < 17
        hit(@dealer)
        display_card(@dealer,-1)
        puts "\nDEALER SCORE: #{@dealer.calculate_score}"
      end
    end

    if bust?(@dealer)
      puts "Dealer bust!"
    elsif bust?(@player)
    else
      winning_hand
    end
    puts

  end

  def deal_starting_hands
    @player = Hand.new("Player")
    2.times { @player.cards_in_hand << @deck.deal }
    @dealer = Hand.new("Dealer")
    2.times { @dealer.cards_in_hand << @deck.deal }
  end

  def bust?(hand)
    if hand.calculate_score > 21
      true
    else
      false
    end
  end

  def hit(target_hand)
    target_hand.cards_in_hand << @deck.deal
  end

  def winning_hand
    puts "\nDealer stands"
    puts
    if @player.calculate_score > @dealer.calculate_score
      puts "Player wins"
    elsif @dealer.calculate_score > @player.calculate_score
      puts "Dealer wins"
    else
      puts "It's a tie."
    end
  end

  private
  def display_card(target_hand,index)
    print "\n#{target_hand.name} was dealt "
    target_hand.cards_in_hand[index].display
  end

end

blackjack_game = Blackjack.new
blackjack_game.play
