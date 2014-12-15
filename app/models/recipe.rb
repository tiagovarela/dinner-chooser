class Recipe < ActiveRecord::Base
  has_many :votes

  validates :name, :submitter, :url, presence: true

  def rank
    votes.ups.count - votes.downs.count
  end
end
