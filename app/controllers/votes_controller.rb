class VotesController < ApplicationController
  def create
    @votable = find_votable
    @vote = @votable.votes.build(vote_params)
  end

  private

  def find_votable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def vote_params
    params.require(:vote).permit(:votable, :vote_count)
  end
end