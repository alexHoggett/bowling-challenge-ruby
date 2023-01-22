require 'app'

describe BowlingGame do
  context 'next_two_scores method' do
    it "returns the sum of the next 2 scores with an array of all numbers" do
      bowling_game = BowlingGame.new

      scores = [[1, 3], [4, 2]]
      expect(bowling_game.next_two_scores(scores)).to eq 4
      scores = [[5, 0], [6, 0]]
      expect(bowling_game.next_two_scores(scores)).to eq 5
    end

    it "returns the sum of the next 2 scores with an array of numbers and strings" do
      bowling_game = BowlingGame.new

      scores = [[10, ''], [2, 4]]
      expect(bowling_game.next_two_scores(scores)).to eq 12
      scores = [[10, 'x'], [10, '']]
      expect(bowling_game.next_two_scores(scores)).to eq 20
    end

    it "returns nil when there are no enough integers present" do
      bowling_game = BowlingGame.new

      scores = [[10, ''], ['', '']]
      expect(bowling_game.next_two_scores(scores)).to eq nil
      scores = [['', ''], ['', '']]
      expect(bowling_game.next_two_scores(scores)).to eq nil
    end
  end
end