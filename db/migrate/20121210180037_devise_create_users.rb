class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :username, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false

      t.timestamps
    end
  end
end
