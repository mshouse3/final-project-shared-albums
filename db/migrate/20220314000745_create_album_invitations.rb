class CreateAlbumInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :album_invitations do |t|
      t.integer :owner_id
      t.integer :member_id
      t.integer :album_id

      t.timestamps
    end
  end
end
