class BowlingGame
  def initialize
    @frame = 0
    @roll = 0
    @score = 0
    @spared = false
    @scores = [['', ''], ['', ''],['', ''],['', ''],['', ''],['', ''],['', ''],['', ''],['', ''],['', '', '']]
  end

  def run
    puts "Welcome to Bowling!"
    
    # for every frame that is not the last frame
    while @frame < 9
      puts ""
      puts "Frame #{@frame + 1}, Bowl #{@roll + 1}"
      puts "Score: #{@score}"
      puts ""
      score = get_score

      if @roll == 0
        # first bowl
        if score < 10
          # not a strike, move to next bowl
          @scores[@frame][@roll] = score
          @roll += 1
        else
          # we got a strike
          @scores[@frame] = [10, '']
          @frame += 1
        end
        check_spare
      else
        # second bowl
        @scores[@frame][@roll] = score
        # is it a spare?
        if score + @scores[@frame][@roll - 1] == 10
          # it's a spare
          @spared = true
        else
          # not a spare :(
          @score += @scores[@frame][@roll - 1] + @scores[@frame][@roll]
        end
        @frame += 1
        @roll = 0
      end
      check_strikes
    end
    # last frame
    @scores[-1].each do
      break if @roll == 2 && @scores[-1][0] != 10
      puts ""
      puts "Frame #{@frame + 1}, Bowl #{@roll + 1}"
      puts "Score: #{@score}"
      puts ""
      score = get_score
      @scores[@frame][@roll] = score
      @score += score
      check_spare
      check_strikes
      @roll += 1
    end

    puts @scores.inspect
    puts "You finished with a score of - #{@score}"
  end

  def get_score
    while true do
      puts "What did you score?"
      score = gets.chomp.to_i
      
      if score < 0 || score > 10
        puts "Enter a number between 0 and 10"
      elsif @roll == 1 && score + @scores[@frame][@roll - 1] > 10 && @frame != 9
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

  def check_strikes
    # loop from first frame
    puts @scores.inspect
    for i in 0...@scores.length do
      if @scores[i] == [10, '']
        # it's a strike so count up the next 2 rolls
        next_two_frames = [@scores[i + 1], @scores[i + 2]]
        unless next_two_scores(next_two_frames).nil?
          @score += next_two_scores(next_two_frames) + 10
          @scores[i] = [10, 'x']
        end
      end
    end
  end

  def next_two_scores(scores)
    # TESTED
    # given an array of 4 numbers, will return the sum of the first 2
    # if there are not enough numbers, will return nil
    sum = 0
    numbers_added = 0
    scores.flatten.each do |score|
      if score.is_a? Integer
        sum += score 
        numbers_added += 1
      end
      break if numbers_added == 2
    end

    if numbers_added < 2
      return nil
    else
      return sum
    end
  end
end

bowling_game = BowlingGame.new
bowling_game.run
