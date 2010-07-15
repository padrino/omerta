Sham.define do
  name        { Faker::Name.first_name                    }
  surname     { Faker::Name.last_name                     }
  username    { Faker::Internet.user_name                 }
  password    { (1..10).map { ('a'..'z').to_a.rand }.join }
  email       { Faker::Internet.email                     }
  title       { Faker::Lorem.words(5).join(' ')           }
  tagline     { Faker::Lorem.words(8).join(' ')           }
  body        { Faker::Lorem.words(10).join(' ')          }
  tags        { Faker::Lorem.words(1).join                }
end


Account.blueprint do
  name                    { Sham.name     }
  surname                 { Sham.surname  }
  username                { Sham.username }
  email                   { Sham.email    }  
  password                { 'testy'       }
  password_confirmation   { 'testy'       }
  role                    { 'admin'       }
end

Blog.blueprint do
  title         { Sham.title            }
  tagline       { Sham.tagline          }
end

Post.blueprint do
 title                   { Sham.title }
 body                    { Sham.body }
 tag_list                { 'test, two' }                 
end
