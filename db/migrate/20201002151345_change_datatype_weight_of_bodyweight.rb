class ChangeDatatypeWeightOfBodyweight < ActiveRecord::Migration[6.0]
  def change
    change_column :bodyweights, :weight, :float
  end
end
