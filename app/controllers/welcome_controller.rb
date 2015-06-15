class WelcomeController < ApplicationController

  def index
   @questions =Question.all
   @question_votes =  Vote.where(votable_type: 'Question').group(:votable_id).sum(:vote_count)
  end

  def search
    @questions = Question.search(params[:search])
  end

end

