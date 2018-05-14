class AddStripeIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :subscribed, :boolean, null: false, default: false
  end
end
