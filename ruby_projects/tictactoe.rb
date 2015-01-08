class Player
  attr_accessor :symbol, :turn, :wins, :name
  WINS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],  # <-- Horizontal wins
      [0, 3, 6], [1, 4, 7], [2, 5, 8],  # <-- Vertical wins
      [0, 4, 8], [2, 4, 6]              # <-- Diagonal wins
    ]
  def initialize(turn, name)
    @symbol = turn == 1? 'x':'o'
    @turn = turn
    @wins = 0
    @name = name
  end

  def add_win
    @wins += 1
  end
  
  def get_name
    @name
  end

  def get_wins
    @wins
  end 

  def check_lines(board)
    if WINS.any? { |line| line.all? { |square| board[square] == turn } }
     return turn
    end
    return nil
  end

  def take_turn(board)
    puts "#{name}, you are player #{@turn}"
    puts "Where do you want to enter: #{@symbol}? (0-8)"
    block = gets.to_i
    while !((0..8) === block) or board.is_taken?(block)
      if !((0..8) === block)
        puts "Invalid input. 0-8 accepted only"     
      else 
        puts "Block already taken. Enter another value" 
      end
      block = gets.to_i
    end
    board[block] = @turn
  end

end


class Board
  attr_accessor :the_board
  def initialize
    @the_board = [0, 0, 0, 0, 0, 0, 0, 0, 0] 
    @size = 9
  end

  def clear_board
    @the_board = [0, 0, 0, 0, 0, 0, 0, 0, 0] 
  end

  def is_taken?(i)
    return @the_board[i] != 0 if i < @size
  end

  def [](y)
    @the_board[y]
  end

  def []=(y, value)
    @the_board[y] = value
  end

  def print_board
    for i in (0..8)
      if i % 3 == 0
        puts ""
      end
      if @the_board[i] == 1
        print '|x|'
      elsif @the_board[i] == 2
        print '|o|'
      else
        print "|#{i}|" 
      end
    end
    puts ""
  end

  def filled?
    return !@the_board.include?(0)
  end



end

class Engine
  attr_accessor :player1, :player2, :board

  def initialize
    puts "Welcome to Tic Tac Toe. There are two players and the goal is to get 3 in a row." 
    puts "Player 1, what is your name?"
    name1 = gets.chomp
    @player1 = Player.new(1, name1)
    puts "Player 2, what is your name?"
    nam2 = gets.chomp
    @player2 = Player.new(2, name1)
    @board = Board.new
  end

  def run
    winner = nil
    @board.clear_board
    while winner.nil?
      @board.print_board
      @player1.take_turn(@board)
      winner = check_winner()
      @board.print_board
      break if winner
      @player2.take_turn(@board)
      winner = check_winner()
    end
    if winner == 1
      print "#{@player1.name} won this round!\n"
      @player1.add_win()
    elsif winner == 2
      print "#{@player2.name} won this round!\n"
      @player2.add_win()
    else
      puts "It was a draw!"
    end
  end

  # 0 if draw, 1 if player 1, 2 if player 2, nil if not over
  def check_winner
    winner = nil
    winner = @player1.check_lines(@board) if @player1.check_lines(@board)
    winner = @player2.check_lines(@board) if winner.nil?
    winner = 0 if @board.filled? and winner.nil?
    return winner
  end

  def print_stats
    print "Player 1 (#{@player1.name}) has: #{@player1.get_wins()} wins \n"
    print "Player 2 (#{@player2.name}) has: #{@player2.get_wins()} wins \n"
  end

  def print_final_stats
    winner = @player1.get_wins() > @player2.get_wins() ? @player1 : @player2
    print "The winner was #{winner.get_name} with #{winner.get_wins} wins. Congrats! \n"
  end

end



game = Engine.new()
user_input = true
while user_input
  game.run
  game.print_stats
  while user_input != 'y' and user_input != 'n'
    puts "Would you like to play again?(y/n)"
    user_input = gets.chomp.downcase
  end
  user_input = true if user_input == 'y'
  user_input = false if user_input == 'n'
end
game.print_final_stats
