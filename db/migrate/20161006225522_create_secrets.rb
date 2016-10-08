class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.integer :user_id
      t.string :secret_message
      t.references :user
      t.timestamps null: false
    end
  end
end
