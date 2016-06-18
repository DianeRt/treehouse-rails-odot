class TodoItemsController < ApplicationController
  def index
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  # GET /todo_lists/:todo_list_id/todo_items/new
  def new
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new
  end

  # from bin/rake routes
  # POST   /todo_lists/:todo_list_id/todo_items(.:format)          todo_items#create
  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "There was a problem adding that todo list item."
      render action: :new
    end
  end

  # this is important when using todo_items_params in create method to avoid error from rails
  # this is called strong parameters:
  # With strong parameters, Action Controller parameters are forbidden to be used in Active Model mass assignments until they have been whitelisted. This means that you'll have to make a conscious decision about which attributes to allow for mass update. This is a better security practice to help prevent accidentally allowing users to update sensitive model attributes.
  # this tells rails what is ok to work with and what it can modify
  private
  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
