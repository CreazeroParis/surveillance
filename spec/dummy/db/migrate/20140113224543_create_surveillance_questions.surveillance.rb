# This migration comes from surveillance (originally 20130626130351)
class CreateSurveillanceQuestions < ActiveRecord::Migration
  def change
    create_table :surveillance_questions do |t|
      t.text :title
      t.text :description
      t.belongs_to :parent, polymorphic: true
      t.string :field_type
      t.boolean :mandatory, default: true
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
