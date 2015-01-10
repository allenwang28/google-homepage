require 'yaml'
class Game
  attr_accessor :word, :correct, :correct_guesses, :misses, :num_guesses, :turns

  def initialize
    @word = generate_word
    @correct = []
    @correct_guesses = []
    @word.each { |word| @correct << '' }
    @misses = []
    @num_guesses = 9
    @turns = 1
  end

  def print_board
    for letter in @correct
      if letter == ''
        print '_'
      else
        print letter
      end
      print ' '
    end
    puts "(#{@correct.length} letters)"
  end

  def start_input
    puts "Type L to load a game or N for a new game: "
    user_input = gets.chomp.downcase
    while user_input != 'l' and user_input != 'n'
      puts "Invalid input"
      user_input = gets.chomp.downcase
    end
    if user_input == 'l'
      if load_game.nil?
        puts "Starting a new game..."
      end
    end
    puts "\n\n\n"
  end

  def run
    puts "Welcome to Hangman!" 

    continue = true
    while continue
      start_input
      while game_status.nil?
        puts "Turn: #{@turns}"
        print_board
        print "You have guessed correctly: "
        @correct_guesses.each { |guess| print "#{guess} " }
        puts ""
        print "You have missed: "
        @misses.each { |guess| print "#{guess} " } 
        puts ""
        puts "You have #{@num_guesses} guesses left"
        user_input = take_turn
        update(user_input)
        @turns += 1
      end

      print_board

      if game_status == 1
        puts "You won!"
      else
        puts "You lost! The word was #{@word.join()}"
      end
      
      continue = continue?
      puts "\n \n \n"
      restart
    end
  end

  def restart
    @word = generate_word
    @correct = []
    @correct_guesses = []
    @word.each { |word| @correct << '' }
    @misses = []
    @num_guesses = 9
    @turns = 1
  end

  def continue?
    puts "Would you like to play again? (y/n): "
    user_input = gets.chomp.downcase
    while user_input != 'y' and user_input != 'n'
      puts "Invalid input"
      user_input = gets.chomp.downcase
    end
    return user_input == 'y'? true:nil
  end

  def update(user_input)
    if user_input == 'save'
      save
    end
    valid = false
    @word.each_with_index do |letter, index|
      if user_input == letter
        valid = true
        @correct[index] = letter
      end
    end 
    if !valid
      @misses << user_input
      @num_guesses -= 1
    else 
      @correct_guesses << user_input
    end
  end
   
  def load_game
    puts "Existing games: "
    entries = []
    Dir.foreach("saves") do |entry|
      unless entry == '.' or entry == '..'
        entries << entry
      end
    end
    if entries.length == 0
      puts "None\n"
      return nil 
    else
      entries.each_with_index { |entry, index| puts "#{index + 1}. #{entry}" }
    end
 
    puts "\n\n\n" 
    puts "Which game would you like to load? (Number only please)" 
    chosen_num = gets.to_s.chomp

    while !chosen_num.match(/\d+/) or chosen_num.to_i > entries.length or chosen_num.to_i <= 0
      puts "Invalid input"
      chosen_num = gets.to_s.chomp 
    end
    
    chosen_game = "saves/" + entries[chosen_num.to_i - 1]
    puts "Loading " + chosen_game + "..."
    loaded_game = YAML.load_file(chosen_game)
    @word = loaded_game.word
    @correct_guesses = loaded_game.correct_guesses
    @correct = loaded_game.correct
    @misses = loaded_game.misses
    @num_guesses = loaded_game.num_guesses
    @turns = loaded_game.turns 
    return true

  end

  def save
    Dir.mkdir("saves") unless Dir.exists?("Saves")
    title = "saves/" + Time.now.to_s[0..18].gsub(/[\s:-]/, '') + ".yaml"
    File.open(title, 'w') do |file|
      file.puts YAML.dump(self)
    end 
    puts "Game saved as #{title}!" 
    abort
  end

  def generate_word
    all_words = File.readlines("dictionary.txt")
    filtered_words = all_words.select { |word| (5..12) === word.chomp.length } 
    filtered_words[rand(filtered_words.length)].chomp.downcase().split('')
  end

  def take_turn
    puts "Enter a letter, or 'save' to save and quit: "
    user_input = gets.to_s.chomp.downcase()
    all_guesses = @correct_guesses + @misses
    while (!user_input.match(/[a-z]/) or user_input.length != 1) and user_input != 'save' or all_guesses.include?(user_input)
      puts "Invalid input. Try again: "
      user_input = gets.to_s.chomp.downcase()
    end
    user_input
  end

  def game_status
    if @num_guesses == 0 
      0
    else
      if @correct == @word
        1
      end   
    end
  end

end

engine = Game.new
engine.run
