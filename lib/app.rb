class BowlingGame
  def initialize
    @frame = 0
    @bowl = 0
    @score = 0
    @striked = false
    @spared = false
    @scores = [[0, 0], [0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0, 0]]
  end

  def run
    puts "Welcome to Bowling!"
    
    # for every frame that is not the last frame
    while @frame < 9
      puts ""
      puts "Frame #{@frame + 1}, Bowl #{@bowl + 1}"
      puts "Score: #{@score}"
      puts ""

      if @bowl == 0
        # first bowl
        score = get_score

        if score < 10
          # not a strike, move to next bowl
          @scores[@frame][@bowl] = score
          @bowl += 1
        else
          # we got a strike
          @striked = true
          @scores[@frame] = ['x', 'x']
          @frame += 1
        end
        check_spare
      else
        # second bowl
        score = get_score
        @scores[@frame][@bowl] = score
        # is it a spare?
        if score + @scores[@frame][@bowl - 1] == 10
          # it's a spare
          @spared = true
        elsif !@striked
          # not a spare :(
          @score += @scores[@frame][@bowl - 1] + @scores[@frame][@bowl]
        end
        check_strike
        @frame += 1
        @bowl = 0
      end
    end

  end

  def get_score
    while true do
      puts "What did you score?"
      score = gets.chomp.to_i
      
      if score < 0 || score > 10
        puts "Enter a number between 0 and 10"
      elsif @bowl == 1 && score + @scores[@frame][@bowl - 1] > 10
        puts "That's more than a strike!"
      else
        break
      end
    end
    return score
  end

def check_spare
  if @spared
    # add first bowl from current frame to past frames bowls
    @score += @scores[@frame - 1][0] + @scores[@frame - 1][1] + @scores[@frame][0]
    @spared = false
  end
end

def check_strike
  if @striked
    @score += 10 + @scores[@frame][0] + @scores[@frame][1]
    @striked = false
  end
end

end

bowling_game = BowlingGame.new
bowling_game.run
