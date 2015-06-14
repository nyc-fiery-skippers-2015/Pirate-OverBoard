class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user
  validates_uniqueness_of :user, scope: [:votable_id, :votable_type]
  validates_inclusion_of :vote_count, :in => [0, 1, -1]
end
