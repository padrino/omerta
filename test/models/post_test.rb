require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')


context "Post" do
  setup { 
    Post.delete_all 
  }
  
  context "Definition" do 
    setup do 
      Post.make
    end

    asserts_topic.has_key :title,       String
    asserts_topic.has_key :body,        String
    asserts_topic.has_key :tags,        Array
    asserts_topic.has_key :draft,       Boolean
    asserts_topic.has_key :blog_id,     Integer
    asserts_topic.has_key :account_id,  Integer
    
    # associations
    asserts_topic.has_association :belongs_to, :account
    asserts_topic.has_association :belongs_to, :blog
    
    # validates presence of
    asserts_topic.has_validation :validates_presence_of, :title
    asserts_topic.has_validation :validates_presence_of, :body
    asserts_topic.has_validation :validates_presence_of, :slug
    
  end
  
  context "slug is generated" do
   setup { Post.make :title => 'Slug Post' }
   asserts("success") { topic.slug }.equals 'slug_post'
  end
  
  context "scope works" do
    setup { Post.make :title => 'Scope Test' }
    asserts("success") { Post.by_slug('scope_test').first.slug }.equals 'scope_test'
  end

  context "find by slug" do
    setup { Post.make :title => 'Hello There' }
    asserts("success") { Post.find_by_slug('hello_there').slug }.equals 'hello_there'
  end

  
  
  
end
