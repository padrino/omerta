class Post
  include MongoMapper::Document

  key :title,       String,   :required => true
  key :body,        String,   :required => true
  key :tags,        String
  key :draft,       Boolean,  :default => true
  key :blog_id,     ObjectId, :required => true
  key :account_id,  ObjectId, :required => true
  timestamps!
  
  has_permalink :title
  
  belongs_to :blog
  belongs_to :account
  
  # find post by slug
  scope :by_slug, lambda { |slug| where(:slug => slug)}

end
