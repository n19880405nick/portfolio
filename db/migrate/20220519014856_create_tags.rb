class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|

      t.integer :post_id, null: false
      t.string :tag, null: false

      t.timestamps
    end
  end
end
