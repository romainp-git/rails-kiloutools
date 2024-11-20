# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Booking.destroy_all
Product.destroy_all
User.destroy_all
Brand.destroy_all
Category.destroy_all

Brand.count
Category.count
User.count
Product.count
Booking.count

# ==========================================================================
# CATEGORIES CREATION

categories = [
  { name: "Jardinage" },
  { name: "Bricolage" },
  { name: "Menuiserie" },
  { name: "Plomberie" },
  { name: "Maçonnerie" },
  { name: "Peinture" },
  { name: "Mécanique" },
  { name: "Soudure" },
  { name: "Nettoyage" }
]

categories.each do |category|
  Category.create(name: category[:name])
end

# ==========================================================================
# BRANDS CREATION

brands = [
  {name: "Bosch" },
  {name: "DeWalt" },
  {name: "Makita" },
  {name: "Black & Decker" },
  {name: "Milwaukee" },
  {name: "Stanley" },
  {name: "Ryobi" },
  {name: "Hitachi" },
  {name: "Craftsman" },
  {name: "Husqvarna" },
  {name: "Snap-on" },
  {name: "Festool" },
  {name: "Karcher" },
  {name: "Fein" },
  {name: "Hilti" },
  {name: "Metabo" },
  {name: "Ridgid" },
  {name: "Porter-Cable" },
  {name: "Skil" },
  {name: "Irwin" }
]

brands.each do |brand|
  Brand.create(name: brand[:name])
end

# ==========================================================================
# USERS CREATION

require 'faker'

addresses = [
  "123 Rue de la République, 59000 Lille, France",
  "456 Avenue des Champs-Élysées, 59000 Lille, France",
  "789 Boulevard Saint-Germain, 59000 Lille, France",
  "101 Rue de Rivoli, 59000 Lille, France",
  "202 Rue de la Liberté, 59000 Lille, France",
  "303 Rue de la Gare, 59110 La Madeleine, France",
  "404 Rue de la Mairie, 59260 Lezennes, France",
  "505 Rue de la République, 59320 Haubourdin, France",
  "159 Boulevard Voltaire, 75011 Paris, France",
  "707 Rue de la Gare, 59120 Loos, France"
]

users = [
  {
    email: "jean.dupont@example.com",
    password: "password",
    first_name: "Jean",
    last_name: "Dupont",
    username: "jeandupont"
  },
  {
    email: "marie.martin@example.com",
    password: "password",
    first_name: "Marie",
    last_name: "Martin",
    username: "mariemartin"
  },
  {
    email: "pierre.durand@example.com",
    password: "password",
    first_name: "Pierre",
    last_name: "Durand",
    username: "pierredurand"
  },
  {
    email: "sophie.lefevre@example.com",
    password: "password",
    first_name: "Sophie",
    last_name: "Lefevre",
    username: "sophielefevre"
  },
  {
    email: "luc.bernard@example.com",
    password: "password",
    first_name: "Luc",
    last_name: "Bernard",
    username: "lucbernard"
  },
  {
    email: "claire.roux@example.com",
    password: "password",
    first_name: "Claire",
    last_name: "Roux",
    username: "claireroux"
  },
  {
    email: "marc.leclerc@example.com",
    password: "password",
    first_name: "Marc",
    last_name: "Leclerc",
    username: "marcleclerc"
  },
  {
    email: "isabelle.moreau@example.com",
    password: "password",
    first_name: "Isabelle",
    last_name: "Moreau",
    username: "isabellemoreau"
  },
  {
    email: "julien.girard@example.com",
    password: "password",
    first_name: "Julien",
    last_name: "Girard",
    username: "juliengirard"
  },
  {
    email: "laura.dubois@example.com",
    password: "password",
    first_name: "Laura",
    last_name: "Dubois",
    username: "lauradubois"
  }
]

users.each_with_index do |user, index|
  User.create(
    email: user[:email],
    password: user[:password],
    password_confirmation: user[:password],
    first_name: user[:first_name],
    last_name: user[:last_name],
    username: user[:username],
    address: addresses[index]
  )
end

# ==========================================================================
# PRODUCTS CREATION

users = User.all

products = [
  {
    name: "Tondeuse à gazon",
    description: "Tondeuse à gazon électrique pour jardins de taille moyenne.",
    state: Product::STATES.sample,
    model: "GLM 120",
    price: 150.0,
    brand_id: Brand.find_by(name: "Bosch").id,
    category_id: Category.find_by(name: "Jardinage").id,
    user_id: User.all.sample.id
  },
  {
    name: "Perceuse",
    description: "Perceuse sans fil avec batterie lithium-ion.",
    state: Product::STATES.sample,
    model: "DCD771C2",
    price: 80.0,
    brand_id: Brand.find_by(name: "DeWalt").id,
    category_id: Category.find_by(name: "Bricolage").id,
    user_id: User.all.sample.id
  },
  {
    name: "Scie circulaire",
    description: "Scie circulaire portable pour coupes précises.",
    state: Product::STATES.sample,
    model: "561534-7",
    price: 120.0,
    brand_id: Brand.find_by(name: "Makita").id,
    category_id: Category.find_by(name: "Menuiserie").id,
    user_id: User.all.sample.id
  },
  {
    name: "Clé à molette",
    description: "Clé à molette ajustable pour divers travaux de plomberie.",
    state: Product::STATES.sample,
    model: "85601",
    price: 20.0,
    brand_id: Brand.find_by(name: "Stanley").id,
    category_id: Category.find_by(name: "Plomberie").id,
    user_id: User.all.sample.id
  },
  {
    name: "Truelle",
    description: "Truelle en acier inoxydable pour travaux de maçonnerie.",
    state: Product::STATES.sample,
    model: "12345",
    price: 15.0,
    brand_id: Brand.find_by(name: "Ryobi").id,
    category_id: Category.find_by(name: "Maçonnerie").id,
    user_id: User.all.sample.id
  },
  {
    name: "Pistolet à peinture",
    description: "Pistolet à peinture électrique pour travaux de peinture.",
    state: Product::STATES.sample,
    model: "W970",
    price: 70.0,
    brand_id: Brand.find_by(name: "Black & Decker").id,
    category_id: Category.find_by(name: "Peinture").id,
    user_id: User.all.sample.id
  },
  {
    name: "Cric hydraulique",
    description: "Cric hydraulique pour levage de véhicules.",
    state: Product::STATES.sample,
    model: "3-Ton",
    price: 50.0,
    brand_id: Brand.find_by(name: "Craftsman").id,
    category_id: Category.find_by(name: "Mécanique").id,
    user_id: User.all.sample.id
  },
  {
    name: "Poste à souder",
    description: "Poste à souder à l'arc pour travaux de soudure.",
    state: Product::STATES.sample,
    model: "Easyweld 2.0",
    price: 200.0,
    brand_id: Brand.find_by(name: "Husqvarna").id,
    category_id: Category.find_by(name: "Soudure").id,
    user_id: User.all.sample.id
  },
  {
    name: "Aspirateur",
    description: "Aspirateur sans fil pour nettoyage domestique.",
    state: Product::STATES.sample,
    model: "V8 Absolute",
    price: 100.0,
    brand_id: Brand.find_by(name: "Karcher").id,
    category_id: Category.find_by(name: "Nettoyage").id,
    user_id: User.all.sample.id
  },
  {
    name: "Scie sauteuse",
    description: "Scie sauteuse pour coupes précises et courbes.",
    state: Product::STATES.sample,
    model: "JS300",
    price: 90.0,
    brand_id: Brand.find_by(name: "Bosch").id,
    category_id: Category.find_by(name: "Bricolage").id,
    user_id: User.all.sample.id
  }
]

products.each do |product|
  Product.create!(product)
end

# ==========================================================================
# BOOKINGS CREATION

# Statuts possibles pour les réservations
STATUS = ["En attente", "Accepté", "Refusé"]

# Générer 10 réservations avec des données fictives
10.times do
  Booking.create!(
    start_date: Faker::Date.between(from: '2024-01-01', to: '2024-12-31'),
    end_date: Faker::Date.between(from: '2024-01-01', to: '2024-12-31'),
    status: statuses.sample,
    amount: Faker::Commerce.price,
    product_id: Product.all.sample.id,
    user_id: User.all.sample.id
  )
end
