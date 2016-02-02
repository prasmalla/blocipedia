require 'faker'

# admin user
User.skip_callback(:initialize, :after, :set_role)
user = User.new(
  name: 'admin',
  email: 'default@user.com',
  password: 'dafault1',
  role: 'admin'
)
user.skip_confirmation!
user.save!
User.set_callback(:initialize, :after, :set_role)

# users
3.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.skip_confirmation!
  user.save! 
end
users = User.all

# wikis
18.times do
  Wiki.create(
    title: Faker::Hipster.sentence(3),
    body: Faker::Hipster.paragraph,
    user: users.sample
  )
end

