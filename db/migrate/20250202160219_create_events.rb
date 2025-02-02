class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name, limit: 200
      t.text :description
      t.timestamp :started_at
      t.timestamp :finished_at

      t.timestamps
    end
  end
end
