class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  validates :body, presence: true
  validates_uniqueness_of :only_one_best_answer, if: :only_one_best_answer

  private

  def only_one_best_answer
    if best_answer == true && Answer.find_by(best_answer: true) == true
      errors[:name] = 'There is already a best answer'
    end
  end
end
