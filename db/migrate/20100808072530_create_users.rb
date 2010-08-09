class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name,:last_name,:email,:title,:password,:current_address,:resident_address,:city,:user_type
      t.integer :phone_number,:postal_code,:updated_by,:created_by

      t.timestamps
    end
    User.create(:first_name=>"Admin",:email=>"admin@helios.com",:password=>"helios")
    puts "Your Username:admin@helios.com & password:helios"
  end

  def self.down
    drop_table :users
  end
end
