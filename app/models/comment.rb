class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :article
  has_many :votes, as: :voteable, dependent: :destroy

  validates :body, presence: true

  def points
    return 0 if votes.empty?
    votes.map(&:score).reduce(:+)
  end

end
