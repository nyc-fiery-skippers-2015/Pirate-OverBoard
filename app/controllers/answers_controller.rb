class AnswersController < ApplicationController
  before_action :require_login

  def new
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find_by(id: params[:question_id])
    @answer = @question.answers.build(answers_params)
    @answer.user = current_user
    if @answer.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit
    @answer = found_answer
    @question = @answer.question
  end

  def update
    @answer = found_answer
    @question = @answer.question
    @answer.update(answers_params)
    if @answer.save
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @answer = found_answer
    @question = @answer.question
    @answer.destroy
    redirect_to question_path(@question)
  end

  def vote
    @answer = found_answer
    vote = Vote.create(vote_count: params[:vote_count], user: current_user, votable: @answer)
    if vote.valid?
      flash[:notice] = "You voted"
    else
      flash[:error] = "You cannot vote more than once"
    end
    redirect_to :back
  end

  def update_best_answer
    @answer = found_answer
    @answer.best_answer = true
    if @answer.save
      redirect_to :back
    else
      flash[:error] = "There was an error"
      redirect_to :back
    end
  end

  private

  def found_answer
    Answer.find_by(id: params[:id])
  end

  def answers_params
    params.require(:answer).permit(:body, :user_id)
  end
end