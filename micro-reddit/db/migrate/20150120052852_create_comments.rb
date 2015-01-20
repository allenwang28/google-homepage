class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post, index: true
      t.references :comment, index: true 
      t.timestamps null: false
    end
  end
end
