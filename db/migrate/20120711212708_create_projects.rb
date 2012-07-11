class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.integer :dollars_needed
      t.integer :days_left
      t.string :school
      t.string :city
      t.string :state
      t.string :teacher
      t.string :project_id

      t.timestamps
    end
  end
end
