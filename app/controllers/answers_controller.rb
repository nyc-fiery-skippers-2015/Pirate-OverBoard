class AnswersController < ApplicationController
  def new
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find_by(id: params[:question_id])
    @answer = @question.answers.build(answers_params)
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

  private

  def answers_params
    params.require(:answer).permit(:body, :user_id)
  end
end