# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
    u1 = User.create!(email: 'cwhite@gmail.com')
    u2 = User.create!(email: 'bwarford@gmail.com')
  
    su1 = ShortenedUrl.user_and_long_to_short(
      u1, 'www.google.com'
    )
  
    su2 = ShortenedUrl.user_and_long_to_short(
      u2, 'www.google2.com'
    )
  
    su3 = ShortenedUrl.user_and_long_to_short(
      u2, 'www.imdb.com'
    )
  
    Visit.record_visit!(u1, su1)
    Visit.record_visit!(u1, su1)
    Visit.record_visit!(u1, su2)
  
    Visit.record_visit!(u2, su2)
    Visit.record_visit!(u2, su2)
    Visit.record_visit!(u2, su1)
    Visit.record_visit!(u2, su3)
  
    tt1 = TagTopic.create!(name: 'Search')
    tt2 = TagTopic.create!(name: 'Movies')
  
    Tagging.create!(short_url: su1, tag_topic: tt1)
    Tagging.create!(short_url: su2, tag_topic: tt1)
    Tagging.create!(short_url: su3, tag_topic: tt2)
  end