class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @model = params[:model]
    if @model == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @model == "Book"
      @books = Book.looks(params[:search], params[:word])
    elsif @model == "Group"
      @groups = Group.looks(params[:search], params[:word])
    end
  end
end
