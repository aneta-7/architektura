class Ad < ApplicationRecord
 validates :name, :description, :price, :seller_id, :email, :url_img,  presence: true
 validates :name, :description, length: {minimum: 3}
 validates :email, length: {minimum: 4}
 validates :price, length: {minimum: 1}

end
