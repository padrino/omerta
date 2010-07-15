class Blog
  include MongoMapper::Document

  # key <name>, <type>
  key :title,   String,      :required => true
  key :url,     String,      :required => true
  key :tagline, String
  timestamps!
  
  many :posts

  validates_uniqueness_of :title, :url
  validates_format_of :url, :with => /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  # grab the domain from the current blog
  def domain
    re = /^(?:(?>[a-z0-9-]*\.)+?|)([a-z0-9-]+\.(?>[a-z]*(?>\.[a-z]{2})?))$/i
    self.url.gsub(re, '\1').strip
  end
  
  
end
