class BlogRoll
  include MongoMapper::Document

  # key <name>, <type>
  key :title, String
  key :link, String
  key :description, String
  timestamps!
end
