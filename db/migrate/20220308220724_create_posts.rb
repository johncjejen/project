class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :Title
      t.string :description
      t.string :author
      t.date :publication_date

      t.timestamps
    end
  end
end
