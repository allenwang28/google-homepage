class UsersController < ApplicationController
  
  def index
    @name = "I am the index"
  end

  def show
    @name = "Show!"
  end

  def new
    @name = "New!"
  end

  def edit
    @name = "Edit!"
  end
  
  def create

  end
end
