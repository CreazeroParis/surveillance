# This migration comes from surveillance (originally 20130703113456)
class CreateSurveillanceAttempts < ActiveRecord::Migration
  def change
    create_table :surveillance_attempts do |t|
      t.belongs_to :user, polymorphic: true
      t.integer :survey_id
      t.string :ip_address

      t.timestamps
    end
  end
end
