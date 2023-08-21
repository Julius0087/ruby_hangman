require_relative 'game_class'
require 'yaml'

def save_name
  loop do
    puts 'Name your save: '
    name = gets.chomp
    if File.exists?("saves/#{name}.yaml")
      choice = nil
      puts 'Save already exists. Would you like to overwrite it? (y/n)'
      loop do
      choice = gets.chomp
      break if ['y', 'n'].include? choice
      puts 'Invalid choice. Select "y" or "n".'
      end

      if choice == 'y'
        return name
      else
        next
      end
    else
      return name
    end
  end
end

def choose_name
  # TODO:
  # better way to show the files
  if Dir.empty?('saves')
    puts 'No save file found.'
    exit
  end

  loop do
    puts 'Choose a saved game: '
    files = Dir.entries("saves").select { |f| File.file? File.join("saves", f) }
    files.each { |file| file.slice!('.yaml') }
    puts files

    choice = gets.chomp
    if File.exists?("saves/#{choice}.yaml")
      return choice
    else
      puts "Invalid name. Save doesn't exist"
      next
    end
  end
end
    

def save_game(current_game)
  serialized_object = YAML.dump(current_game)
  file = File.open("saves/#{save_name}.yaml", "w") { |file| file.write serialized_object }
end

def load_game
  save = File.open("saves/#{choose_name}.yaml")
  deserialized_object = YAML.unsafe_load(save)
  save.close
  puts 'Game loaded'
  deserialized_object
end


choice = nil
puts 'Welcome to hangman, would you like to (1) start a new game or (2) load a saved game?'
loop do
  choice = gets.chomp
  break if ['1', '2'].include? choice

  puts 'Please select 1 or 2'
end
game = choice == '1' ? Game.new : load_game

until game.out_of_guesses? do
  # display the word in hidden/guessed state
  game.display_word
  # display incorrect guesses
  puts "Incorrect guesses left: #{game.guesses_left}"
  # ask for input, check if the guess was correct
  input = game.register_input
  # check for save - save the game
  if input == 'save'
    save_game(game)
    puts 'Game saved.'
    exit
  end
  # check for win
  if game.check_for_win
    puts 'Congratulations! You win!'
    puts "The word was: #{game.word}"
    exit
  end
  # repeat
end
puts "Out of turns. The word was: #{game.word}"

# DONE:

