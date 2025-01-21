9.times do |i|
  product = Product.new(
              name: "Product #{i + 1}",
              description: 'Good Product',
              price: 100.0,
              stock_quantity: 5
            )
  product.product_picture.attach(io: File.open(Rails.root.join("app", "assets", "images", "product.jpg")), filename: 'product.jpg', content_type: "image/jpg")
  product.save!
end
