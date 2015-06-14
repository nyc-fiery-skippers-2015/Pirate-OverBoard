class Question < ActiveRecord::Base
  after_create :default_vote

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :title, :body


  def default_vote
    vote = self.votes.build(vote_count:0)
    vote.user = self.user
    vote.save
  end

end