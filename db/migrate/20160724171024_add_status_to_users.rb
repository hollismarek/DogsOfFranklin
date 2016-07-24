class AddStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :status, :string
    User.all.each do |user|
      user.status = 'Active'
      user.save
    end
  end
end
