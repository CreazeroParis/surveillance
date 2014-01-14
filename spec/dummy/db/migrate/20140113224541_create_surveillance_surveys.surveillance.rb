# This migration comes from surveillance (originally 20130626115136)
class CreateSurveillanceSurveys < ActiveRecord::Migration
  def change
    create_table :surveillance_surveys do |t|
      t.string :title
      t.text :description
      t.text :last_page_description
      t.date :end_date
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
