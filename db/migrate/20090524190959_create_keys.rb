class CreateKeys < ActiveRecord::Migration
  def self.up
    create_table :keys do |t|
      t.column "license_key", :string
      t.column "url", :string
      t.timestamps
    end
    
    add_index :keys, :url
  end

  def self.down
    drop_table :keys
  end
end
