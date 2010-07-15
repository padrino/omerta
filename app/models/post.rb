class Post
  include MongoMapper::Document

  key :title,       String,   :required => true
  key :body,        String,   :required => true
  key :tags,        Array
  key :draft,       Boolean,  :default  => true
  # key :blog_id,     ObjectId, :required => true
  # key :account_id,  ObjectId, :required => true
  timestamps!
  
  has_permalink :title
  
  # belongs_to :blog
  # belongs_to :account
    
  # find post by permalink
  scope :find_by_permalink, lambda { |permalink| where(:permalink => permalink) }

end
