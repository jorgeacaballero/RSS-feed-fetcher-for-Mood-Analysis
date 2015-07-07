class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :app, index: true
      t.string :title
      t.text :content
      t.integer :rating

      t.timestamps null: false
    end
    add_foreign_key :reviews, :apps
  end
end
