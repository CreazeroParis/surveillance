# This migration comes from surveillance (originally 20130702111125)
class CreateSurveillanceOptions < ActiveRecord::Migration
  def change
    create_table :surveillance_options do |t|
      t.string :title
      t.integer :question_id
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
