class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :recipe, index: true
      t.boolean :up, null: false

      t.timestamps
    end
  end
end
