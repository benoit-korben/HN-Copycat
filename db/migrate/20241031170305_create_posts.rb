class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :post_type
      t.string :url
      t.string :author
      t.integer :score

      t.timestamps
    end
  end
end
