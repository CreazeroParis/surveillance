class CreateSurveillanceAnswersOptionsJoinTable < ActiveRecord::Migration
  def change
    create_table :surveillance_answers_options do |t|
      t.references :answer, :option
    end
  end
end
