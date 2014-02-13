class AddAccessTokenToSurveillanceAttempts < ActiveRecord::Migration
  def change
    add_column :surveillance_attempts, :access_token, :string
  end
end
