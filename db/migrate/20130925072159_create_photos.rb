class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user

      t.string :name
      t.string :file
      t.string :remote_url
      t.integer :views # 查看次数

      t.timestamps
    end
  end
end
