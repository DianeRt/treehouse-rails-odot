class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      # Original t.reference in this file did not include index:true
      # I manually added it because it was in the treehouse video
      # changed t.referenc to t.references to fix db:migrate error
      t.references :todo_list, index:true
      t.string :content

      # Original t.timestamp has null:false setting
      # I removed it because it wasn't in the treehouse video
      # DEPRECATION WARNING: `#timestamps` was called without specifying an option for `null`. In Rails 5, this behavior will change to `null: false`. You should manually specify `null: true` to prevent the behavior of your existing migrations from changing.
      t.timestamps
    end
  end
end
