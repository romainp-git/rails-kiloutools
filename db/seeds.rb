
puts "Cleaning database..."
Product.destroy_all
Category.destroy_all
Brand.destroy_all
User.destroy_all

["Electro", "Jardin"].each do |cat|
  Category.create!(name: cat)
end

["Bosch", "Parkside"].each do |brand|
  Brand.create!(name: brand)
end

user = User.create!(
  email: 'test@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  address: 'Lille'
)

user2 = User.create!(
  email: 'testazfa@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  address: 'Paris'
)

["Perceuse", "Visseuse", "Scie", "Tournevis"].each do |outil|
  Product.create!(name: outil, category: Category.last, brand: Brand.last, user: user)
end

Product.create!(name: "Perceuse", category: Category.first, brand: Brand.first, user: user2)
