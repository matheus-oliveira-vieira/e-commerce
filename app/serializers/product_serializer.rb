class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :description, :price, :product_picture_url

  def product_picture_url
    if object.product_picture.attached?
      Rails.application.routes.default_url_options[:host] = "http://localhost:3000"
      rails_blob_url(object.product_picture, only_path: true)
    else
      nil
    end
  end
end
