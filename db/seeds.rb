# User
User.create!(name: "nguyenvana", email: "nguyenvana@gmail.com",
  password: "123456", password_confirmation: "123456", admin: true)
User.create!(name: "nhinguyen", email: "nhinguyen@gmail.com",
  password: "123456", password_confirmation: "123456", admin: true)
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email,
    password: password, password_confirmation: password)
end

# Publisher
20.times do |n|
  name = Faker::Name.name
  address = Faker::Address.full_address
  Publisher.create!(name: name, address: address)
end

Author
20.times do |n|
  name = Faker::Name.name
  content = Faker::Lorem.sentence(5)
  Author.create!(name: name, content: content)
end

# Category
name= ["Viet Nam", "Van hoc", "Hien dai", "Toan hoc",  "Dai so", "Giai tich", "Nuoc Ngoai", "Van hoc", "Hien dai", "Toan hoc"]
parent_id = [0, 1, 2, 1, 4, 4, 0, 7,8,7]
path = ["1-", "1-2-", "1-2-3-", "1-4-", "1-4-5-", "1-4-6-", "7-", "7-8", "7-8-9", "7-10-" ]
for i in 0..9 do
  Category.create!(name: name[i], parent_id: parent_id[i], path: path[i])
end

# Book
 id = [3,5,6,9]
 for i in id do
  5.times do |n|
    name = Faker::Book.title
    content =Faker::Lorem.sentence(20)
    Book.create!(name: name, category_id: i, author_id: i, publisher_id: i, content: content, number_page: 200, year: 2018, status: "Done")
  end
end
