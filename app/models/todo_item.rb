class TodoItem < ActiveRecord::Base
  # this is automatically added when specifying it when using:
  # bin/rails generate model todo_item todo_list:references content:string
  # the references part is important to automatically add "belongs_to" in this file
  belongs_to :todo_list

  # you can write validations like this:
  # do not forget the comma after each line
  validates :content, presence: true,
                      length: { minimum: 2 }

  # this is used for the TodoList model (app/models/todo_list.rb)
  # Scoping allows you to specify commonly-used queries which can be referenced as method calls on the association objects or models. With these scopes, you can use every method previously covered such as where, joins and includes. All scope methods will return an ActiveRecord::Relation object which will allow for further methods (such as other scopes) to be called on it.
  scope :complete, -> { where("completed_at is not null") }
  scope :incomplete, -> { where(completed_at: nil) }

  def completed?
    !completed_at.blank?
  end
end
