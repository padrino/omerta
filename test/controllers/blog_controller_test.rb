require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

context "BlogController" do
  context "description here" do
    setup do
      Blog.delete_all
      @blog = Blog.make :link => "http://www.google.com/"
      get "/"
    end

    asserts(:status).equals(200)
    asserts("last response body") { last_response.body }.matches /Google Blog/

  end
end
