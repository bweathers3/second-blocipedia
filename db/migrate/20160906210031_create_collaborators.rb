class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.boolean :approved
      t.references :user, index: true, foreign_key: true
      t.references :wiki, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
