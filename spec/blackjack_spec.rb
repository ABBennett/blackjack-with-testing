require_relative '../blackjack'

describe Hand do
  let(:hand) {Hand.new}

  describe "#cards_in_hand" do
    it "should be an array" do
      expect(hand.cards_in_hand).to be_a(Array)
    end
  end
end

describe Blackjack do
  let(:blackjack) { Blackjack.new }

  describe "#deal_starting_hands" do
    it "should be a hand hand" do
      expect(blackjack.player).to be_a(Hand)
    end

    it "should put two cards in each hand" do
      expect(blackjack.player.cards_in_hand.size).to eq(2)
      expect(blackjack.dealer.cards_in_hand.size).to eq(2)
    end
  end

  describe "#hit" do
    it "should add a card to the target hand" do
      blackjack.hit(blackjack.player)
      expect(blackjack.player.cards_in_hand.size).to eq(3)
      blackjack.hit(blackjack.dealer)
      expect(blackjack.dealer.cards_in_hand.size).to eq(3)
    end
  end

  describe "#calculate_score" do
    it "should return a zero if there are no cards" do
      expect(Hand.new.calculate_score).to eq(0)
    end

    it "should add up the score" do
      hand_1 = Hand.new
      hand_1.cards_in_hand << Card.new(5,"♠")
      hand_1.cards_in_hand << Card.new("K","♠")
      expect(hand_1.calculate_score).to eq(15)
    end

    it "should use the right ace value" do
      hand_2 = Hand.new
      hand_2.cards_in_hand << Card.new('A',"♠")
      hand_2.cards_in_hand << Card.new(9,"♠")
      hand_2.cards_in_hand << Card.new("A","♥")
      expect(hand_2.calculate_score).to eq(21)
    end

    it "should use the right ace value" do
      hand_3 = Hand.new
      hand_3.cards_in_hand << Card.new('A',"♠")
      hand_3.cards_in_hand << Card.new('A',"♠")
      hand_3.cards_in_hand << Card.new("A","♥")
      expect(hand_3.calculate_score).to eq(13)
    end

    it "should use the right ace value" do
      hand_4 = Hand.new
      hand_4.cards_in_hand << Card.new(7,"♠")
      hand_4.cards_in_hand << Card.new(8,"♠")
      hand_4.cards_in_hand << Card.new("A","♥")
      hand_4.cards_in_hand << Card.new(7,"♥")
      expect(hand_4.calculate_score).to eq(23)
    end

    it "should use the right ace value" do
      hand_5 = Hand.new
      hand_5.cards_in_hand << Card.new(2,"♠")
      hand_5.cards_in_hand << Card.new(5,"♠")
      hand_5.cards_in_hand << Card.new("A","♥")
      hand_5.cards_in_hand << Card.new(2,"♥")
      hand_5.cards_in_hand << Card.new("A","♥")
      expect(hand_5.calculate_score).to eq(21)
    end
  end

  describe "#winning_hand" do
    let(:card_1) {Card.new(2,"♠")}
    let(:card_2) {Card.new(5,"♠")}
    let(:card_3) {Card.new("A","♥")}
    let(:hand_1) { Hand.new }

    let(:card_4) {Card.new(2,"♠")}
    let(:card_5) {Card.new(5,"♠")}
    let(:card_6) {Card.new("A","♥")}
    let(:hand_2) { Hand.new }
    it "should return the winning hand" do
      hand_1.cards_in_hand = [card_1, card_2, card_3]
      blackjack.player.cards_in_hand = hand_1.cards_in_hand
      
      hand_2.cards_in_hand = [card_4, card_5, card_6]
      blackjack.dealer.cards_in_hand = hand_2.cards_in_hand


      expect{blackjack.winning_hand}.to output(/tie/).to_stdout
    end
  end
end

# describe "Blackjack" do
#   blackjack_2 = Blackjack.new
#   context "#winning_hand" do
#     it "should return a tie" do
#       @player = Hand.new
#       @player.cards_in_hand << Card.new(8,"♠")
#       @player.cards_in_hand << Card.new(8,"♠")
#       @player.cards_in_hand << Card.new("A","♥")
#       expect(@player.calculate_score).to eq(17)
#
#       @dealer = Hand.new
#       @dealer.cards_in_hand << Card.new(8,"♠")
#       @dealer.cards_in_hand << Card.new(8,"♠")
#       @dealer.cards_in_hand << Card.new("A","♥")
#       expect(@dealer.calculate_score).to eq(17)
#       expect{blackjack_2.winning_hand}.to output(/tie/).to_stdout
#     end
#   end
# end
