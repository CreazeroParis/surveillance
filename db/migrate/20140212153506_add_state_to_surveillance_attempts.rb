class AddStateToSurveillanceAttempts < ActiveRecord::Migration
  def change
    add_column :surveillance_attempts, :state, :string
    add_column :surveillance_attempts, :last_answered_section, :integer
  end
end
