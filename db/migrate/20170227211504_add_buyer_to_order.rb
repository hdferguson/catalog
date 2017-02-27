class AddBuyerToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :buyer, foreign_key: true
  end
end
