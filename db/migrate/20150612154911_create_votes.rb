class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_count
      t.references :votable, polymorphic: true, index: true
      t.belongs_to :user, null:false
      t.timestamps null: false
    end
  end
end
