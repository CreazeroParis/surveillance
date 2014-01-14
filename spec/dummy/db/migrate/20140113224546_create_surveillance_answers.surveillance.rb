# This migration comes from surveillance (originally 20130703115649)
class CreateSurveillanceAnswers < ActiveRecord::Migration
  def change
    create_table :surveillance_answers do |t|
      t.integer :attempt_id
      t.integer :question_id
      t.boolean :other_choosed, default: false

      t.timestamps
    end
  end
end
