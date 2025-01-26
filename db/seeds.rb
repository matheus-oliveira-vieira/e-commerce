9.times do |i|
  product = Product.new(
              name: Faker::Commerce.product_name,
              description: Faker::Quote.yoda,
              price: Faker::Number.number(digits: 3)
            )
  product.product_picture.attach(io: File.open(Rails.root.join("app", "assets", "images", "product.jpeg")), filename: 'product.jpeg', content_type: "image/jpeg")
  product.save!
end
