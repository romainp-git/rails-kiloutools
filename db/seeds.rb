# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

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

descriptions = [
  "Passionné de rénovation, je passe mes week-ends à transformer mon jardin en un véritable havre de paix. J'adore bricoler avec le bois et créer des meubles uniques. N'hésitez pas à me contacter pour louer mes outils de menuiserie !",
  "Amoureuse des DIY, je suis toujours à la recherche de nouveaux projets créatifs. Je suis équipée pour tout type de travaux de décoration et de rénovation. Louez mes outils pour donner vie à vos idées les plus folles !",
  "Ancien maçon de métier, je suis un expert en rénovation. Je possède un large éventail d'outils pour tous les travaux de maçonnerie, de plâtrerie et d'électricité. N'hésitez pas à faire appel à moi pour vos projets de rénovation !",
  "Passionnée de jardinage, je cultive mon propre potager et entretiens mon jardin avec soin. Je dispose de tous les outils nécessaires pour l'entretien de votre jardin. Louez mon matériel pour profiter d'un jardin verdoyant !",
  "Mécanicien amateur, je répare tout ce qui tombe sous ma main. Je possède un garage bien équipé et je suis prêt à partager mes outils avec d'autres passionnés de mécanique. N'hésitez pas à me solliciter !",
  "Adepte du relooking, j'adore transformer les meubles et les objets du quotidien. Je suis équipée de tout le matériel nécessaire pour la peinture, le ponçage et la tapisserie. Louez mes outils pour donner une seconde vie à vos meubles !",
  "Électricien de formation, je suis à l'aise avec tous les travaux électriques. Je possède un matériel professionnel et je suis prêt à le partager avec ceux qui ont besoin d'effectuer des travaux électriques en toute sécurité.",
  "Bricoleuse du dimanche, j'aime relever de nouveaux défis et apprendre de nouvelles techniques. Je suis équipée pour les petits travaux de bricolage et de jardinage. N'hésitez pas à me contacter !",
  "Menuisier de métier, je réalise des meubles sur mesure et des travaux d'agencement. Je possède un atelier bien équipé et je suis prêt à partager mes outils avec d'autres passionnés de bois.",
  "Artisan polyvalent, je suis capable de réaliser de nombreux travaux : plomberie, peinture, carrelage... Je possède un large éventail d'outils et je suis prêt à vous aider dans vos projets."
]

users = [
  {
    email: "pym@gmail.com",
    password: "password",
    first_name: "Pierre-Yves",
    last_name: "MEVEL",
    username: "PYM"
  },
  {
    email: "sam@gmail.com",
    password: "password",
    first_name: "Samuel",
    last_name: "WILLEM",
    username: "SAM"
  },
  {
    email: "rom@gmail.com",
    password: "password",
    first_name: "Romain",
    last_name: "PORTIER",
    username: "ROM"
  },
  {
    email: "abe@gmail.com",
    password: "password",
    first_name: "Aurélien",
    last_name: "BERNARD",
    username: "ABE"
  },
  {
    email: "pyh@gmail.com",
    password: "password",
    first_name: "Pierre-Yves",
    last_name: "HOORENS",
    username: "PYH"
  },
  {
    email: "afl@gmail.com",
    password: "password",
    first_name: "Arnaud",
    last_name: "FLORIANI",
    username: "AFL"
  },
  {
    email: "cgu@gmail.com",
    password: "password",
    first_name: "Camille",
    last_name: "GUILMAIN",
    username: "CGU"
  },
  {
    email: "cba@gmail.com",
    password: "password",
    first_name: "Clara",
    last_name: "BARBE",
    username: "CBA"
  },
  {
    email: "jde@gmail.com",
    password: "password",
    first_name: "Jean",
    last_name: "DELABRE",
    username: "JDE"
  },
  {
    email: "jtc@gmail.com",
    password: "password",
    first_name: "John",
    last_name: "TCHOMGUI",
    username: "JTC"
  }
]

users.each_with_index do |user, index|
  begin
    current_user = User.create!(
      email: user[:email],
      password: user[:password],
      password_confirmation: user[:password],
      first_name: user[:first_name],
      last_name: user[:last_name],
      username: user[:username],
      address: addresses[index] || Faker::Address.full_address, # Utiliser Faker si l'index dépasse le tableau
      description:descriptions[index]
    )
    puts "Created user: #{current_user.email}"

    # Chemin de la photo de l'utilisateur
    username_photo_path = Rails.root.join('app', 'assets', 'images', "#{current_user.username}.png")
    default_photo_path = Rails.root.join('app', 'assets', 'images', 'no_profile.png')    # Upload de la photo sur Cloudinary

    # Vérifier si la photo de l'utilisateur existe
    if File.exist?(username_photo_path)
      result = Cloudinary::Uploader.upload(username_photo_path)
      current_user.photo.attach(io: URI.open(result['secure_url']), filename: result['original_filename'])
      puts "Uploaded photo for: #{current_user.username}"
    else
      # Si la photo n'existe pas, utiliser la photo par défaut
      result = Cloudinary::Uploader.upload(default_photo_path)
      current_user.photo.attach(io: URI.open(result['secure_url']), filename: result['original_filename'])
      puts "No photo found for: #{current_user.username}. Default photo uploaded."
    end

    puts "URL photo: #{result}"

  rescue => e
    puts "Failed to create user #{user[:email]}: #{e.message}"
  end
end

# ==========================================================================
# PRODUCTS CREATION

users = User.all

products = [
  {
    name: "Tondeuse à gazon",
    description: "Tondeuse à gazon électrique pour jardins de taille moyenne.",
    state: Product::STATES.sample,
    model: "GLM120",
    price: 150.0,
    brand_id: Brand.find_by(name: "Bosch").id,
    category_id: Category.find_by(name: "Jardinage").id,
    user_id: User.find
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
    model: "5615347",
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
    model: "3Ton",
    price: 50.0,
    brand_id: Brand.find_by(name: "Craftsman").id,
    category_id: Category.find_by(name: "Mécanique").id,
    user_id: User.all.sample.id
  },
  {
    name: "Poste à souder",
    description: "Poste à souder à l'arc pour travaux de soudure.",
    state: Product::STATES.sample,
    model: "Easyweld20",
    price: 200.0,
    brand_id: Brand.find_by(name: "Husqvarna").id,
    category_id: Category.find_by(name: "Soudure").id,
    user_id: User.all.sample.id
  },
  {
    name: "Aspirateur",
    description: "Aspirateur sans fil pour nettoyage domestique.",
    state: Product::STATES.sample,
    model: "V8Absolute",
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
    status: STATUS.sample,
    amount: Faker::Commerce.price,
    product_id: Product.all.sample.id,
    user_id: User.all.sample.id
  )
end
