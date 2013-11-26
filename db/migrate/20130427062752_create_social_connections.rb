class CreateSocialConnections < ActiveRecord::Migration
  def change
    create_table :social_connections do |t|
      t.integer :user_id
      t.string :provider
      t.string :token
      t.string :provider_id

      t.timestamps
    end
  end
end
