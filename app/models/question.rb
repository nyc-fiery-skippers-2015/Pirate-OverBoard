class Question < ActiveRecord::Base
  after_create :default_vote

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :title, :body


  def my_time
    self.created_at.strftime("%B %d, %Y")
  end

  def default_vote
    vote = self.votes.build(vote_count:0)
    vote.user = self.user
    vote.save
  end

  def self.search(search)
    if search
      Question.where('title LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end
end
