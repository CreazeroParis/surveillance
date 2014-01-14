class CreateSurveillanceSections < ActiveRecord::Migration
  def change
    create_table :surveillance_sections do |t|
      t.string :title
      t.text :description
      t.integer :position, default: 0
      t.integer :survey_id

      t.timestamps
    end
  end
end
