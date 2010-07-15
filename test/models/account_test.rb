require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

#asserts("that record is not nil") { !topic.nil? }

context "Account" do
  setup { Account.delete_all }

  context "definition" do
       setup { Account.make }
       asserts_topic.has_key :name,             String
       asserts_topic.has_key :surname,          String
       asserts_topic.has_key :role,             String
       asserts_topic.has_key :email,            String
       asserts_topic.has_key :salt,             String
       asserts_topic.has_key :crypted_password, String
       asserts_topic.has_key :username,         String
       
       # associations
       asserts_topic.has_association :many, :posts

       # responds to
       asserts_topic.responds_to :password
       asserts_topic.responds_to :password_confirmation
   
       # validates presence of
       asserts_topic.has_validation :validates_presence_of, :email
       asserts_topic.has_validation :validates_presence_of, :username
       asserts_topic.has_validation :validates_presence_of, :role
       asserts_topic.has_validation :validates_presence_of, :password, :if => :password_required
       asserts_topic.has_validation :validates_presence_of, :password_confirmation, :if => :password_required
       
       # validates confirmation of
       asserts_topic.has_validation :validates_confirmation_of, :password, :if => :password_required
       
       # validates length of
       asserts_topic.has_validation :validates_length_of, :password, :within => 4..40, :if => :password_required
       asserts_topic.has_validation :validates_length_of, :email, :within => 3..100
       
       #validates uniqueness
       asserts_topic.has_validation :validates_uniqueness_of, :email, :case_sensitive => false
       
       # validates format of
       asserts_topic.has_validation :validates_format_of, :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
       asserts_topic.has_validation :validates_format_of, :role, :with => /[A-Za-z]/
     end
   
     context "authenticate method" do
       setup { Account.make :password => 'test', :password_confirmation => 'test', :email => 'bob@test.com' }
       asserts("passes") { Account.authenticate('bob@test.com','test') }
       asserts("fails")  { Account.authenticate('bob@test.com','fail') }.nil
     end
   
     context "find_by_id method" do
       setup { Account.make }
       asserts("finds account") { Account.find_by_id(topic.id) }
     end
   
     context "password_clean method" do
       setup { Account.make :password => 'password', :password_confirmation => 'password' }
       asserts("success") { topic.password_clean }.equals 'password'
     end
 
end