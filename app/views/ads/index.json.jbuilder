json.array!(@ads) do |ad|
  json.extract! ad, :id, :name, :description, :price, :seller_id, :email, :url_img
  json.url ad_url(ad, format: :json)
end
