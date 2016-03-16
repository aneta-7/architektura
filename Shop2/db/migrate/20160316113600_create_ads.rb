class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :seller_id
      t.string :email
      t.string :url_img

      t.timestamps
    end
  end
end
