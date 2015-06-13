class CommentsController < ApplicationController

  def new
    @commentable = find_commentable
    @comment = Comment.new
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = User.find_by(id: session[:user_id])
    if @comment.save && params[:question_id]
      redirect_to question_path(@commentable)
    elsif @comment.save
      redirect_to question_path(@commentable.question)
    else
      render :new
    end
  end

  def edit
    @commentable = find_commentable
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @commentable = find_commentable
    @comment = Comment.find_by(id: params[:id])
    @comment.update(comment_params)
    if @comment.save && params[:question_id]
      redirect_to question_path(@commentable)
    elsif @comment.save
      redirect_to question_path(@commentable.question)
    else
      render :edit
    end
  end

  def destroy
    @commentable = find_commentable
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    if params[:question_id]
      redirect_to question_path(@commentable)
    else @comment.save
      redirect_to question_path(@commentable.question)
    end
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def comment_params
    params.require(:comment).permit(:commentable, :body)
  end
end