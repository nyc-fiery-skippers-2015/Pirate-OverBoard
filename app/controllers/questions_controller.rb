class QuestionsController < ApplicationController

  def index
    if params[:order]
      @questions = Question.order(updated_at: :desc)
      render :index_chrono
    else
      @questions = Question.joins(:votes).group(:id).order('SUM(votes.vote_count) DESC')
      render :index
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
    @question_comments = @question.comments
    @best_answer = Answer.find_by(question: @question, best_answer: true)
    @answers = Answer.where(question: @question, best_answer: false)
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

  def vote
    @question = Question.find_by(id: params[:id])
    vote = Vote.create(vote_count: params[:vote_count], user: User.find_by(id: session[:user_id]), votable: @question)
    if vote.valid?
      flash[:notice] = "You voted"
    else
      flash[:error] = "You cannot vote more than once"
    end
    redirect_to :back
  end


  private
  def question_params
    params.require(:question).permit(:title, :body)
  end


end