class CreatePlanets < ActiveRecord::Migration[5.0]
  def change
    create_table :planets do |t|
      t.string :name, null: false
      t.decimal :mass
      t.integer :diameter
      t.integer :density
      t.decimal :gravity
      t.decimal :rotation_period
      t.decimal :length_of_day
      t.decimal :distance_from_sun
      t.decimal :orbital_period
      t.decimal :orbital_velocity
      t.integer :mean_temperature
      t.integer :number_of_moons

      t.timestamps
    end

    add_index :planets, :name, unique: true
  end
end
