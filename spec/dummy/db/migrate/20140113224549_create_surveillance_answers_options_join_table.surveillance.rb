# This migration comes from surveillance (originally 20130711100032)
class CreateSurveillanceAnswersOptionsJoinTable < ActiveRecord::Migration
  def change
    create_table :surveillance_answers_options do |t|
      t.references :answer, :option
    end
  end
end
