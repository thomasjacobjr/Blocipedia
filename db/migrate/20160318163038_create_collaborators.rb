class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :user_id
      t.integer :wiki_id

      t.timestamps null: false
    end
  end
end
