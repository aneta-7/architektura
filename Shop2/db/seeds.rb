require 'faker'

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
	       activated: true,
	       activated_at: Time.zone.now)
end

99.times do |n|
	Ad.create(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.characters(80),
        price: Faker::Number.decimal(2),
        seller_id: Faker::Number.between(0,99),
        email: Faker::Internet.email,
	url_img: Faker::Avatar.image
)
end
 
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
