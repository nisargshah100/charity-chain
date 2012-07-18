class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :external_id
      t.integer :external_source
      t.text :data
      t.timestamps
    end
  end
end
