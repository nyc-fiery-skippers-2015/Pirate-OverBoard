class AnswersController < ApplicationController
  def new
    if session[:user_id]
      @question = Question.find_by(id: params[:question_id])
      @answer = Answer.new
    else
      redirect_to login_path
    end
  end

  def create
    @question = Question.find_by(id: params[:question_id])
    @answer = @question.answers.build(answers_params)
    @answer.user = User.find_by(id: session[:user_id])
    if @answer.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit
    @answer = Answer.find_by(id: params[:id])
    @question = @answer.question
  end

  def update
    @answer = Answer.find_by(id: params[:id])
    @question = @answer.question
    @answer.update(answers_params)
    if @answer.save
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @answer = Answer.find_by(id: params[:id])
    @question = @answer.question
    @answer.destroy
    redirect_to question_path(@question)
  end

  def vote
    if session[:user_id]
      @answer = Answer.find_by(id: params[:id])
      vote = Vote.create(vote_count: params[:vote_count], user: User.find_by(id: session[:user_id]), votable: @answer)
      if vote.valid?
        flash[:notice] = "You voted"
      else
        flash[:error] = "You cannot vote more than once"
      end
      redirect_to :back
    else
      redirect_to login_path
    end
  end

  def update_best_answer
    @answer = Answer.find_by(id: params[:id])
    @answer.best_answer = true
    if @answer.save
      redirect_to :back
    else
      flash[:error] = "There was an error"
      redirect_to :back
    end
  end

  private

  def answers_params
    params.require(:answer).permit(:body, :user_id)
  end
end