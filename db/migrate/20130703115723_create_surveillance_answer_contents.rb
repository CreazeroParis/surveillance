class CreateSurveillanceAnswerContents < ActiveRecord::Migration
  def change
    create_table :surveillance_answer_contents do |t|
      t.text :value
      t.integer :answer_id

      t.timestamps
    end
  end
end
