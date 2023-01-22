class BowlingGame
  def initialize
    @roll = 0
    @bowl = 0
    @score = 0
    @striked = false
    @spared = false
    @scores = [[0, 0], [0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0, 0]]
  end

  def run
    puts "Welcome to Bowling!"
    
    # for every frame that is not the last frame
    while @roll < 9
      puts ""
      puts "Frame #{@roll + 1}, Bowl #{@bowl + 1}"
      puts "Score: #{@score}"
      puts ""
      score = get_score

      if @bowl == 0
        # first bowl
        if score < 10
          # not a strike, move to next bowl
          @scores[@roll][@bowl] = score
          @bowl += 1
        else
          # we got a strike
          # @striked = true
          @scores[@roll] = [10, 0]
          @roll += 1
        end
        check_spare
      else
        # second bowl
        @scores[@roll][@bowl] = score
        # is it a spare?
        if score + @scores[@roll][@bowl - 1] == 10
          # it's a spare
          @spared = true
        elsif !@striked
          # not a spare :(
          @score += @scores[@roll][@bowl - 1] + @scores[@roll][@bowl]
        end
        check_strike(@roll)
        @roll += 1
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
      elsif @bowl == 1 && score + @scores[@roll][@bowl - 1] > 10
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
    @score += @scores[@roll - 1][0] + @scores[@roll - 1][1] + @scores[@roll][0]
    @spared = false
  end
end

def check_strikes(frames)
    # check if last frame was also a strike
    if @scores[frame - 1] == [10, 0]
      # last frame was a strike
      @score += 10 + @scores[frame][0] + @scores[frame][1]
      @scores[frame - 1][1] = 'x'
      check_strike(frame - 1)
    end
  end
end

end

bowling_game = BowlingGame.new
bowling_game.run
