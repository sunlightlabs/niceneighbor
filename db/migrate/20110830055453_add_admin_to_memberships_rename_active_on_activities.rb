class AddAdminToMembershipsRenameActiveOnActivities < ActiveRecord::Migration
  def self.up
    add_column :memberships, :is_admin, :boolean
    rename_column :activities, :active, :is_active
  end

  def self.down
    remove_column :memberships, :is_admin
    rename_column :activities, :is_active, :active
  end
end
