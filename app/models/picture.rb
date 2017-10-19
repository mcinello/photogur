class Picture < ApplicationRecord

  validates :artist, :url, presence: true
  validates :title, length: {in: 3..20}
  validates :url, uniqueness: true, format: {with: URI::regexp(%w(http)), :message => "Valid URL required"}

  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.pictures_created_in_year(year)
    #Picture.where("cast(strftime('%Y', created_at) as int) = ?", year)
  end

end
