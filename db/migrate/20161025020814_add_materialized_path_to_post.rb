class AddMaterializedPathToPost < ActiveRecord::Migration
  def change
    add_column :posts, :mat_path, :string, null: false, default: '/'
  end
end
