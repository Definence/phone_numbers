
class CreatePhoneNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_numbers do |t|
      t.string :number, unique: true, null: false
      t.timestamps
    end

    add_reference :phone_numbers, :user, index: true, null: false
  end
end
