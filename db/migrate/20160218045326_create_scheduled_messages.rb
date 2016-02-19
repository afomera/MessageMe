class CreateScheduledMessages < ActiveRecord::Migration
  def change
    create_table :scheduled_messages do |t|
      t.references :group, index: true, foreign_key: true
      t.string :body
      t.datetime :scheduled_at
      t.string :status
      t.references :user, index: true, foreign_key: true
      t.datetime :last_sent_on

      t.timestamps null: false
    end
  end
end
