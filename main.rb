class Mastermind
  COLORS = %w[red blue green yellow orange purple]

  def initialize
    @code = generate_code
    @turns = 12
  end

  def play
    puts "Welcome to Mastermind! You have 12 turns to guess the code."
    puts "The code consists of four colors: #{COLORS.join(", ")}"

    loop do
      puts "You have #{@turns} turns left."
      guess = prompt_guess
      break if guess == @code
      evaluate_guess(guess)
      @turns -= 1
      if @turns == 0
        puts "You ran out of turns! The code was #{@code}."
        break
      end
    end

    puts "Game over!"
  end

  private

  def generate_code
    COLORS.sample(4)
  end

  def prompt_guess
    loop do
      print "Enter your guess (e.g. 'red blue green yellow'): "
      guess = gets.chomp.split
      if guess.length == 4 && guess.all? { |color| COLORS.include?(color) }
        return guess
      else
        puts "Invalid guess. Please enter four colors separated by spaces."
      end
    end
  end

  def evaluate_guess(guess)
    exact_matches = 0
    near_matches = 0
    remaining_code = @code.dup

    guess.each_with_index do |color, i|
      if color == @code[i]
        exact_matches += 1
        remaining_code[i] = nil
      end
    end

    guess.each_with_index do |color, i|
      if remaining_code.include?(color)
        near_matches += 1
        remaining_code[remaining_code.index(color)] = nil
      end
    end

    puts "#{exact_matches} exact matches, #{near_matches} near matches"
  end
end

game = Mastermind.new
game.play
