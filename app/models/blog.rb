class Blog
  include MongoMapper::Document

  # key <name>, <type>
  key :title, String
  key :link, String
  key :tagline, String
  timestamps!
  
  many :posts
  
  validates_presence_of :title, :link, :tagline
  validates_uniqueness_of :title, :link
  validates_format_of :link, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  # grab the domain from the current blog
  def domain
    host = URI.parse(self.link).host
    re = /^(?:(?>[a-z0-9-]*\.)+?|)([a-z0-9-]+\.(?>[a-z]*(?>\.[a-z]{2})?))$/i
    host.gsub(re, '\1').strip
  end
  
  
end
