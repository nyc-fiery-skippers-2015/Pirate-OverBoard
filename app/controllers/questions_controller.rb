class QuestionsController < ApplicationController

  def index
    if params[:order]
      @questions = Question.order(:updated_at)
      render :index_chrono
    else
      @questions = Question.joins(:votes).group(:id).order('SUM(votes.vote_count) DESC')
      render :index
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = User.find_by(id: session[:user_id])
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end


  def update
    @question = Question.find_by(id: params[:id])
    if @question.update_attributes(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.destroy
    redirect_to questions_path
  end


  private
  def question_params
    params.require(:question).permit(:title, :body)
  end


end