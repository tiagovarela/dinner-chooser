class Recipe < ActiveRecord::Base
  has_many :votes

  before_save :set_image_url

  validates :name, :submitter, :url, presence: true
  validates :url, format: { with: URI.regexp }, if: Proc.new { |a| a.url.present? }

  def rank
    votes.ups.count - votes.downs.count
  end

  private

  def set_image_url
    mechanize = Mechanize.new
    if url =~ /allrecipes\.com/
      page = mechanize.get(url)
      self.image_url = page.search("//img[@id='imgPhoto']/@src").text
    elsif url =~ /foodnetworktv\.com/
      page = mechanize.get(url)
      self.image_url = page.search("//div[@class='main-food-image-holder']/img/@src").text
    elsif url =~ /smittenkitchen\.com/
      page = mechanize.get(url)
      self.image_url = page.search("//div[@class='entry']//img").first.search('@src').text
    elsif url =~ /saborintenso\.com/
      page = mechanize.get(url)
      self.image_url = page.search("//div[@id='posts']//div[@align='center']//img/@src").to_a.select{|i| i.to_s =~ /images\/receitas/}.first.text
    elsif url =~ /1001receitas\.com/
      page = mechanize.get(url)
      self.image_url = page.search("//img[@itemprop='photo']/@src").text
    elsif url =~ /lifestyle\.sapo\.pt/
      page = mechanize.get(url)
      self.image_url = page.search("//div[@class='bottom-space thumb']//img/@data-src").text
    elsif url =~ /teleculinaria\.pt/
      page = mechanize.get(url)
      self.image_url = "http://www.teleculinaria.pt" + page.search("//img[@class='ImagemDetalhe ImagemDetalheBIG Traduzir box-sh']/@src").text
    elsif url =~ /myrestaurant\.pt/
      page = mechanize.get(url)
      self.image_url = page.search("//img[@typeof='foaf:Image']/@src").first.text
    elsif url =~ /receitas-de-bacalhau\.info/
      page = mechanize.get(url)
      self.image_url = page.search("//div[@class='post-thumbnail']/img[@class='attachment-post-thumbnail wp-post-image']/@src").text
    elsif url =~ /cincoquartosdelaranja\.com/
      page = mechanize.get(url)
      self.image_url = page.search("//div[@class='post-body entry-content']//img").first.search('@src').text
    end
  end
end
