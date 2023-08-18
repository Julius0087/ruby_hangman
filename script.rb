
class Game
  def initialize
    @guessed_arr = []
    @guesses_left = 10
  end

  

  def play
    word = generate_word
    loop do
      turn = play_turn(word)
      if turn
        puts 'You win!'
        puts word
        exit
      end
      break if @guesses_left == 0
    end
    puts 'Out of turns. The word was:'
    puts word
  end

  def generate_word
    f = File.read('google-10000-english-no-swears.txt').split
    # keep randomly selecting until a word between 5 and 12 char. long
    word = nil
    loop do
      word = f.sample
      break if word.length > 4 && word.length < 13
    end
    word
  end

  def play_turn(word)
    display_word(word)
    puts "Incorrect guesses left: #{@guesses_left}"
    guess = nil
    loop do
      puts 'Guess a letter:'
      guess = gets.chomp.downcase
      if guess.length == 1 && guess.match?(/[[:alpha:]]/)
        if @guessed_arr.include?(guess)
          puts 'Letter already guessed'
          next
        else
          break
        end
      else
      puts 'Only single characters allowed'
      end
    end
    unless check_if_correct(word, guess)
      @guesses_left -= 1
    end
    @guessed_arr.push(guess)
    
    check_for_win(word)
    
  end

  def display_word(word)
    arr = word.split('')
    print_arr = []
    arr.each do |char|
      if @guessed_arr.include?(char)
        print_arr.push(char)
      else
        print_arr.push('_ ')
      end
    end
    puts print_arr.join('')
    puts "Letters guessed: #{@guessed_arr}"
  end

  def check_for_win(word)
    arr = word.split('')
    arr.each do |char|
      unless @guessed_arr.include?(char)
        return false
      end
    end
    true
  end

  def check_if_correct(word, guess)
    if word.split('').include?(guess)
      true
    else
      false
    end
  end
end

game = Game.new
game.play
