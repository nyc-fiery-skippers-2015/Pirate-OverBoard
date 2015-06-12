class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null:false
      t.references :commentable, polymorphic: true, index: true
      t.belongs_to :user, null:false
      t.timestamps null: false
    end
  end
end
