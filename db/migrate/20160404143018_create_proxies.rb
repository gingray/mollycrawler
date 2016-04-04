class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|
      t.string   "address"
      t.string   "port"
      t.string   "username"
      t.string   "password"
      t.timestamps null: false
    end
  end
end
