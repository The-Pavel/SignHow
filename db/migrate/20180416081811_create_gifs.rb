class CreateGifs < ActiveRecord::Migration[5.1]
  def change
    create_table :gifs do |t|
      t.string :title
      t.string :language
      t.string :file
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
