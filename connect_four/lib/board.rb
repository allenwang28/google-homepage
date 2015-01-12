Length = 6
Width = 7
class Board
  attr_accessor :pieces, :length, :width 

  def initialize
    @width = Width
    @length = Length
    @pieces = Array.new(Width) { |index| Array.new(Length) { |i| 0 } }
  end

  def clear
    @length = Length
    @width = Width
    @pieces = Array.new(Width) { |index| Array.new(Length) { |i| 0 } }
  end

  def add_piece(col, player)
    column = col - 1
    return false if column > @width or column < 0
    return false unless (1..2) === player
    return false if @pieces[column].none? { |piece| piece == 0 } # full
    i = 0
    until pieces[column][i] == 0
      i += 1
    end
    @pieces[column][i] = player
    return true
  end

  def game_status
    winner = nil
    for x in (0..@width - 1)
      for y in (0..@length - 1)  
        winner = check_hor(x, y) unless check_hor(x,y).nil?
        winner = check_ver(x, y) unless check_ver(x,y).nil?
        winner = check_left_diag(x, y) unless check_left_diag(x,y).nil?
        winner = check_right_diag(x, y) unless check_right_diag(x,y).nil?
        return winner if winner
      end
    end
    @pieces.each { |column| winner |= column.none? { |piece| piece == 0 } }
    return winner == false ? nil : 0 
  end

  def check_hor(x, y)
    player = @pieces[x][y]
    return nil if player == 0
    consecutive = 0
    hor = x
    until @pieces[hor][y] != player or hor == 0
      hor -= 1 
    end 
    until @pieces[hor][y] != player or hor == @width
      hor += 1
      consecutive += 1
    end 

    return consecutive >= 4 ? player : nil
  end

  def filled?(column)
    @pieces[column - 1].none? { |piece| piece == 0 }
  end 


  def check_ver(x, y)
    player = @pieces[x][y]
    return nil if player == 0
    consecutive = 0
    ver = y
    until @pieces[x][ver] != player or ver == 0
      ver -= 1
    end
    until @pieces[x][ver] != player or ver == @length - 1
      ver += 1
      consecutive += 1
    end

    return consecutive >= 4 ? player : nil
  end

  def check_left_diag(x, y)
    player = @pieces[x][y]
    return nil if player == 0
    hor = x
    ver = y
    consecutive = 0
    until @pieces[hor][ver] != player or ver == 0 or hor == @width - 1
      hor += 1
      ver -= 1
    end
    until @pieces[hor][ver] != player or ver == @length or hor < 0
      hor -= 1
      ver += 1
      consecutive += 1
    end

    return consecutive >= 4 ? player : nil
  end

  def check_right_diag(x, y)
    player = @pieces[x][y]
    return nil if player == 0
    hor = x
    ver = y
    consecutive = 0
    until @pieces[hor][ver] != player or ver == 0 or hor == 0
      hor -= 1
      ver -= 1
    end
    until @pieces[hor][ver] != player or ver == @length or hor == @width
      hor += 1
      ver += 1
      consecutive += 1
    end
    return consecutive >= 4 ? player : nil
  end

  def [](index)
    @pieces[index]
  end

  def print_board
    puts ""
    (@length-1).downto(0) do |y|
      for x in (0..@width - 1)
        if @pieces[x][y] != 0
          print "|#{@pieces[x][y]}| "
        else
          print "| | "
        end
      end
      puts ""
    end
    for x in (1..@width)
      print " #{x}  "
    end
    puts "\n\n"
  end

end
