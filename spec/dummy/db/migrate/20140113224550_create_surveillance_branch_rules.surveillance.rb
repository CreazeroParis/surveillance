# This migration comes from surveillance (originally 20130729143002)
class CreateSurveillanceBranchRules < ActiveRecord::Migration
  def change
    create_table :surveillance_branch_rules do |t|
      t.integer :question_id
      t.integer :sub_question_id
      t.string :condition
      t.string :action

      t.timestamps
    end
  end
end
