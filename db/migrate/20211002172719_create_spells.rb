class CreateSpells < ActiveRecord::Migration[6.1]
  def change
    create_table :spells do |t|
      t.text :name
      t.text :source
      t.text :description
      t.string :school
      t.integer :level
      t.boolean :is_ritual
      t.text :casting_time
      t.string :range
      t.text :components
      t.string :duration
      t.text :higher_levels_info
      t.string :spell_lists

      t.timestamps
    end
  end
end
