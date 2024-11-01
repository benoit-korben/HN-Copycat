class CreateUpvotes < ActiveRecord::Migration[7.2]
  def change
    create_table :upvotes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
