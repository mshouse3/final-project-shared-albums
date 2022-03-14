class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.integer :owner_id
      t.string :title

      t.timestamps
    end
  end
end
