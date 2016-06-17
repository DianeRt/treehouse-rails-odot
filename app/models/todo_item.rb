class TodoItem < ActiveRecord::Base
  # this is automatically added when specifying it when using:
  # bin/rails generate model todo_item todo_list:references content:string
  # the references part is important to automatically add "belongs_to" in this file
  belongs_to :todo_list
end
