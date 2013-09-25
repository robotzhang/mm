class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :file
      t.integer :views # 查看次数

      t.timestamps
    end
  end
end
