class Recipe < ActiveRecord::Base
  has_many :votes

  before_save :set_image_url

  validates :name, :submitter, :url, presence: true

  def rank
    votes.ups.count - votes.downs.count
  end

  private

  def set_image_url
    mechanize = Mechanize.new
    page = mechanize.get(url)
    self.image_url = page.search("//img[@id='imgPhoto']/@src").text
  end
end
