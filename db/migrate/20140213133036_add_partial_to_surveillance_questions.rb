class AddPartialToSurveillanceQuestions < ActiveRecord::Migration
  def change
    add_column :surveillance_questions, :partial, :string
  end
end
