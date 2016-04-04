class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string   "tid"
      t.string   "type_name"
      t.text     "meta",       default: "--- {}\n"
      t.integer  "parent_id"
      t.string   "processor"

      t.timestamps null: false
    end
  end
end
