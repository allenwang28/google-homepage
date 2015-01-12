require 'rspec'
require './lib/connect_four.rb'

describe Board do
  let(:board) { Board.new }

  describe '#new' do
    it 'creates a Board instance' do
      expect(board).to be_instance_of Board
    end
  end

  describe '#clear' do
    before(:each) do 
      board.clear
    end

    it 'yields the right dimensions' do
      expect(board.length).to eq Board::Length
      expect(board.width).to eq Board::Width
    end    

    it 'is empty' do
      emptyboard = Array.new(Width) { |index| Array.new(Length) { |i| 0 } }
      expect(board.pieces).to eql emptyboard
    end

  end

  describe '#filled?' do
    before(:each) do
      board.clear
    end

    it 'returns true when space is present' do
      expect(board.filled?(1)).to be false
    end

    it 'returns false when filled' do
      for i in (0..Board::Length)
        board.add_piece(1, 1)
      end
      expect(board.filled?(1)).to be true
    end

  end

  describe '#add_piece' do 
    before(:each) do
      board.clear
    end
    
    it 'adds a piece when there is space' do
      column = 3
      player = 1
      board.add_piece(column, player).should be true
    end

    it 'places a value at the bottom' do
      column = 5 #1 - 7
      player = 1 #1 or 2
      board.add_piece(column, player).should be true
      board[column - 1][0].should == player
    end

    it 'does not add a piece when overflowed' do
      column = 3
      player = 1
      for i in (0..Board::Length)
        board.add_piece(column, player)
      end
      board.add_piece(column, player).should be false
    end

    it 'only accepts a value in the right range' do
      board.add_piece(9, 1).should be false
    end

    it 'only accepts two players' do
      board.add_piece(3,1).should be true
      board.add_piece(3,2).should be true
      board.add_piece(3,3).should be false
    end
  end

  describe '#game_status' do
    before(:each) do
      board.clear
    end    

    it 'confirms horizontal winner' do
      for i in (0..4) do
        board.add_piece(i, 1)
      end
      board.game_status.should eq 1
    end

    it 'confirms vertical winner' do
      column = 1
      for i in (0..4)
        board.add_piece(column,1)
      end
      board.game_status.should eq 1
    end

    it 'confirms right diagonal winner' do
      board.add_piece(1,1)
      board.add_piece(2,2)
      board.add_piece(2,1)
      board.add_piece(3,2)
      board.add_piece(3,2)
      board.add_piece(3,1)
      board.add_piece(4,2)
      board.add_piece(4,2)
      board.add_piece(4,2)
      board.add_piece(4,1)
      board.print_board
      board.game_status.should eq 1
    end

    it 'confirms left diagonal winner' do
      board.add_piece(4,1)
      board.add_piece(3,2)
      board.add_piece(3,1)
      board.add_piece(2,2)
      board.add_piece(2,2)
      board.add_piece(2,1)
      board.add_piece(1,2)
      board.add_piece(1,2)
      board.add_piece(1,2)
      board.add_piece(1,1)
      board.print_board
      board.game_status.should eq 1
    end
  end
end
