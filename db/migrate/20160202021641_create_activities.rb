class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :trackable_id
      t.string :trackable_type
      t.string :action

      t.timestamps null: false
    end
  end
end
