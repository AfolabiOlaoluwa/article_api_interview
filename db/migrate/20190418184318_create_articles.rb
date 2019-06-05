class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.string :description
      t.integer :favorites_count
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
