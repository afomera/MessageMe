class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.references :contact, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
