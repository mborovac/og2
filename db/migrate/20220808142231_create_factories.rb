class CreateFactories < ActiveRecord::Migration[7.0]
  def change
    create_table :factories do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.string :type, null: false
      t.integer :level, null: false, default: 1

      # perhaps could have gone the JSON path here, keeping it dirty and simple because of the time constraint
      t.timestamp :upgraded_to_level_two_at
      t.timestamp :upgraded_to_level_three_at
      t.timestamp :upgraded_to_level_four_at
      t.timestamp :upgraded_to_level_five_at

      t.timestamps
    end

    add_index :factories, :type, unique: true
  end
end
