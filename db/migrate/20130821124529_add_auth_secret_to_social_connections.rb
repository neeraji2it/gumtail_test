class AddAuthSecretToSocialConnections < ActiveRecord::Migration
  def change
    add_column :social_connections,:auth_secret,:string
  end
end
