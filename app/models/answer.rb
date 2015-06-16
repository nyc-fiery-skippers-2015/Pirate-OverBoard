class Answer < ActiveRecord::Base
  after_create :default_vote
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true
  validates_uniqueness_of :only_one_best_answer, if: :only_one_best_answer

  def default_vote
    vote = self.votes.build(vote_count:0)
    vote.user = self.user
    vote.save
  end

  def my_time
    self.created_at.strftime("%B %d, %Y")
  end

  def vote_count
    votes.sum(:vote_count)
  end

  private

  def only_one_best_answer
    if best_answer == true && Answer.find_by(best_answer: true) == true
      errors[:name] = 'There is already a best answer'
    end
  end
end
