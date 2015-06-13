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