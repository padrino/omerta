require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')


context "Post" do
  setup do
    Blog.delete_all
    Post.delete_all
    Account.delete_all
  end
  
  context "Definition" do 
    setup { Post.make }

    asserts_topic.has_key :title,       String,     :required => true
    asserts_topic.has_key :body,        String,     :required => true
    asserts_topic.has_key :tags,        Array
    asserts_topic.has_key :permalink,   String
    asserts_topic.has_key :draft,       Boolean,    :default  => true
    asserts_topic.has_key :blog_id,     ObjectId,   :required => true
    asserts_topic.has_key :account_id,  ObjectId,   :required => true
    # 
    # # associations
    asserts_topic.has_association :belongs_to, :account, :foreign_key => :account_id
    asserts_topic.has_association :belongs_to, :blog,    :foreign_key => :blog_id
  end
    
  context "permalink generated" do
    setup { Post.make :title => 'Scope Test' }
    asserts(:permalink).equals 'scope-test'
  end

  context "find by permalink" do
    setup { Post.make :title => 'Hello There' }
    asserts("success") { Post.find_by_permalink('hello-there').first }.exists
    asserts("error") { Post.find_by_permalink('bad-permalink').first }.nil
  end
end
