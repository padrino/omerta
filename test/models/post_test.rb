require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')


context "Post" do
  setup { Post.delete_all }
  
  context "Definition" do 
    setup { Post.make }

    asserts_topic.has_key :title,       String,   :required => true
    asserts_topic.has_key :body,        String,   :required => true
    asserts_topic.has_key :tags,        Array
    asserts_topic.has_key :permalink,   String
    asserts_topic.has_key :draft,       Boolean,  :default  => true
    # asserts_topic.has_key :blog_id,     Integer,  :required => true
    # asserts_topic.has_key :account_id,  Integer,  :required => true
    # 
    # # associations
    # asserts_topic.has_association :belongs_to, :account
    # asserts_topic.has_association :belongs_to, :blog    
  end
    
  context "permalink generated" do
    setup { Post.make :title => 'Scope Test' }
    asserts(:permalink).equals 'scope-test'
  end

  context "find by permalink" do
    setup { Post.make :title => 'Hello There' }
    asserts("success") { Post.find_by_permalink('hello_there') }
  end
end
