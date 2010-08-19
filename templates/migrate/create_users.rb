class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :<%=file_name.pluralize%> do |t|
      t.string  :email, :default => "", :null => false
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      t.string :perishable_token, :default => "", :null => false
      t.string  :state, :default => "pending", :limit => 15, :null => false

      t.timestamps
    end
    
    add_index :<%=file_name.pluralize%>, :perishable_token
    add_index :<%=file_name.pluralize%>, :email
  end

  def self.down
    drop_table :<%=file_name.pluralize%>
  end
end
