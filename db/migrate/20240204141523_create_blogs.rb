class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content
      t.string :author

      t.timestamps
    end
  end
end
