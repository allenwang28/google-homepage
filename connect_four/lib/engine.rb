require './lib/board'
class Engine
  attr_accessor :board, :current_player

  def initialize
    @board = Board.new
    @current_player = 1
  end

  def reset
    @board.clear
    @current_player = 1
  end

  def continue?
    response = nil
    until response == 'y' or response == 'n'
      puts "Would you like to play again? (y/n) "
      response = gets.chomp.downcase
    end
    return response == 'y' ? true : false
  end

  def switch_player
    @current_player = @current_player == 1 ? 2 : 1
  end

  def welcome
    puts "Welcome to connect four!"
    puts "There are two players. You have to get four in a row. Let's go! \n\n\n"
  end

  def get_input
    response = ''
    until /[1-7]/ =~ response and !@board.filled?(response.to_i)
      puts "Player #{@current_player}, which column would you like to put your piece in?" 
      response = gets.chomp
    end
    return response.to_i
  end

  def run
    welcome
    loop do
      reset
      play
      break unless continue?
    end
  end

  def play
    loop do
      board.print_board
      board.add_piece(get_input, @current_player) 
      board.print_board
      switch_player
      break if board.game_status
    end 
    
    if board.game_status == 1
      puts "Player 1 has won!"
    elsif board.game_status == 2
      puts "Player 2 has won!"
    else
      puts "It was a draw!"
    end
  end 

end

