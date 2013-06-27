class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.references :micropost

      t.timestamps
    end
    add_index :comments, :micropost_id
  end
end
