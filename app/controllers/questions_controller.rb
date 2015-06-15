class QuestionsController < ApplicationController
  before_action :require_login, :except => [:index, :show]

  def index
     @question_votes =  Vote.where(votable_type: 'Question').group(:votable_id).sum(:vote_count)
    if params[:order]
      @questions = Question.order(updated_at: :desc)
      render :index_chrono
    else
      @questions = Question.joins(:votes).group(:id).order('SUM(votes.vote_count) DESC')
      render :index
    end
  end

  def show
    @question = found_question
    @question_votes =  Vote.where(votable_type: 'Question').group(:votable_id).sum(:vote_count)
    @best_answer = Answer.find_by(question: @question, best_answer: true)
    @answer_votes =  Vote.where(votable_type: 'Answer').group(:votable_id).sum(:vote_count)
    @answers = Answer.joins(:votes).where(question: @question, best_answer: false).group(:id).order('SUM(votes.vote_count) DESC')
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def edit
    @question = found_question
  end

  def update
    @question = found_question
    if @question.update_attributes(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question = found_question
    if @question.user_id == session[:user_id]
      @question.destroy
      redirect_to questions_path
    else
      redirect_to login_path
    end
  end

  def vote
    @question = found_question
    vote = Vote.create(vote_count: params[:vote_count], user: current_user, votable: @question)
    if vote.valid?
      flash[:notice] = "You voted"
    else
      flash[:error] = "You cannot vote more than once"
    end
    redirect_to :back
  end

  private

  def found_question
    Question.includes(:comments, :answers).find_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

end