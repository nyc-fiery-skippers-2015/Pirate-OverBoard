class Question < ActiveRecord::Base
  after_save :default_vote

  belongs_to :user
  has_many :answers
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  validates_presence_of :title, :body


  def default_vote
    vote = self.votes.build(vote_count:0)
    vote.user = current_user
    vote.save
  end

end



 # Question.joins(:votes).group(:id).order('SUM(votes.vote_count) DESC')
