class AddUniqueIndexToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_index :bookmarks, [:movie_id, :list_id], unique: true
  end
end
