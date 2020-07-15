class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :hashbody
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
