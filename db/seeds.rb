9.times do |i|
  product = Product.new(
              name: "Product #{i + 1}",
              description: 'Good Product',
              price: 100.0
            )
  product.product_picture.attach(io: File.open(Rails.root.join("app", "assets", "images", "product.jpeg")), filename: 'product.jpeg', content_type: "image/jpeg")
  product.save!
end
