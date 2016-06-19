class TodoItem < ActiveRecord::Base
  # this is automatically added when specifying it when using:
  # bin/rails generate model todo_item todo_list:references content:string
  # the references part is important to automatically add "belongs_to" in this file
  belongs_to :todo_list

  # you can write validations like this:
  # do not forget the comma after each line
  validates :content, presence: true,
                      length: { minimum: 2 }

  def completed?
    !completed_at.blank?
  end
end
