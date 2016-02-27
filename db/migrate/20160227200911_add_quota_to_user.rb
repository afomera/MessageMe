class AddQuotaToUser < ActiveRecord::Migration
  def change
    add_column :users, :quota, :integer, default: 0
    add_column :users, :quota_limit, :integer, default: 200
  end
end
