require "spec_helper"
require "zombie"

describe Zombie do
    it "is named Ash" do
        zombie = Zombie.new
        zombie.name.should == 'Ash' 
    end

    it "has no brain" do
        zombie = Zombie.new
        zombie.brains.should < 1
    end

    it "should be hungry" do
        zombie = Zombie.new
        zombie.should be_hungry
    end

    xit "is alive" do #used for debugging

    end
end

