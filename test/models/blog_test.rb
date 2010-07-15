require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

context "Blog" do
  
  setup { Blog.delete_all }
  
  context "definition" do
    setup { Blog.make :link => 'http://www.yahoo.com' }
    
    asserts_topic.has_key :title,       String
    asserts_topic.has_key :tagline,     String
    asserts_topic.has_key :link,        String
    
    # associations
    asserts_topic.has_association :many, :posts
    
    
    # validations
    asserts_topic.has_validation :validates_presence_of,    :title
    asserts_topic.has_validation :validates_presence_of,    :tagline
    asserts_topic.has_validation :validates_presence_of,    :link
    asserts_topic.has_validation :validates_uniqueness_of,  :title
    asserts_topic.has_validation :validates_uniqueness_of,  :link
    asserts_topic.has_validation :validates_format_of,      :link, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    
    
  end
  
  
  context "grabs domain from url" do
    setup { Blog.make :link => 'http://www.yahoo.com'}
    asserts("success") { topic.domain }.equals 'yahoo.com'
  end
  
  
  
end
