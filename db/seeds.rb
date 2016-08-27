require 'random_data'

 5.times do
   User.create!(
   name:      Faker::Name.name ,
   email:     Faker::Internet.email ,
   password: "password",
   password_confirmation: "password",
   confirmed_at: Date.today
   )
 end
  users = User.all


 50.times do

      wiki = Wiki.create!(
      user:   users.sample,
      title:   Faker::Lorem.sentence ,
      body:    Faker::Lorem.paragraph,
      private: Faker::Boolean.boolean(0.4)
   )

end

    puts "Seed finished"
    puts "#{User.count} users created"
    puts "#{Wiki.count} posts created"
