require 'rspec'
require './lib/connect_four.rb'
describe Engine do
  let(:engine) { Engine.new }

  describe '#new' do
    it 'should be an instance of an engine' do
      expect(engine).to be_instance_of Engine 
    end
    
    it 'should contain a board' do
      expect(engine.board).to be_instance_of Board
    end

    it 'should start with player 1' do
      expect(engine.current_player).to eq 1
    end
  end

  describe '#reset' do
    before(:each) do
      engine.reset
    end

    it 'should have an empty board' do
      emptyarray = [ 0, 0, 0, 0, 0, 0] 
      engine.board.pieces.all? { |column| column == emptyarray }.should be true 
    end

    it 'should start with player 1' do
      expect(engine.current_player).to eq 1
    end 
  end

  describe '#continue?' do
    it 'should return true on "y"' do
      allow(engine).to receive(:gets).and_return('y')
      expect(engine.continue?).to be true
    end

    it 'should return false on "n"' do
      allow(engine).to receive(:gets).and_return('n')
      expect(engine.continue?).to be false
    end

  end

  describe '#switch_player' do
    before(:each) do
      engine.reset
    end

    it 'should switch from player 1 to player 2' do
      engine.switch_player
      engine.current_player.should eq 2
    end

    it 'should switch from player 2 to 1' do
      engine.switch_player
      engine.switch_player
      engine.current_player.should eq 1
    end

    it 'should switch from player 1 to 2 to 1' do
      engine.switch_player
      engine.current_player.should eq 2
      engine.switch_player
      engine.current_player.should eq 1
    end

  end

  describe '#get_input' do
    before(:each) { engine.reset }

    it 'allows for integer input' do
      allow(engine).to receive(:gets).and_return('1')
      expect(engine.get_input).to eq 1
    end

  end

  describe '#take_turn' do
  
    it 'allows player 1 to win a game' do
    
    end

    it 'allows player 2 to win a game' do

    end
    
    it 'allows a draw' do

    end

  end

  describe '#play' do

  end

  describe '#run' do
    
  end 


end
