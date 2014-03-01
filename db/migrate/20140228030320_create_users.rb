class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :phone_number
      t.integer :ssn

      t.timestamps
    end
  end
end
