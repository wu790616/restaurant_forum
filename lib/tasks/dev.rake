namespace :dev do

  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    User.all.each do |user|
      if (user.email != "admin@test.com") and (user.email != "test@test.com")
        user.destroy
      end
    end

    20.times do |i|
      User.create!(
        email: FFaker::Internet.email,
        name: FFaker::Name.first_name,
        password: "123456"
      )
    end

    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_comment: :environment do
    Comment.destroy_all

    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
            content: FFaker::Lorem.phrase,
            user: User.all.sample
          )
      end
    end

    puts "have created 3 comments in each restaurant"
  end

end

