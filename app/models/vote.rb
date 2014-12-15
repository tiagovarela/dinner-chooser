class Vote < ActiveRecord::Base
  belongs_to :recipe

  validates :recipe, presence: true
  validates :up, inclusion: [true, false]

  scope :ups, -> { where(up: true) }
  scope :downs, -> { where(up: false) }
end
