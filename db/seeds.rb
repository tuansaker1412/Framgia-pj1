User.create!(name: "Dung CT", email: "tructiepgame@gmail.com",
  password: "123456", password_confirmation: "123456", admin: true)

19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end

users = User.order(:created_at).take 6
15.times do
  title = Faker::Lorem.sentence 1
  content = Faker::Lorem.sentence 5
  users.each {|user| user.microposts.create! title: title, content: content}
end
