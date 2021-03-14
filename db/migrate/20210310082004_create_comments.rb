class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :board, foreign_key: true #外部キー
      t.string :name, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
