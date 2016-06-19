class TodoItemsController < ApplicationController
  before_action :find_todo_list

  def index
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  # GET /todo_lists/:todo_list_id/todo_items/new
  def new
    @todo_item = @todo_list.todo_items.new
  end

  # from bin/rake routes
  # POST   /todo_lists/:todo_list_id/todo_items(.:format)          todo_items#create
  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      flash[:success] = "Added todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "There was a problem adding that todo list item."
      render action: :new
    end
  end

  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def update
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = "Saved todo list item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "That todo item could not be saved."
      render action: :edit
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "Todo list item was deleted."
    else
      flash[:error] = "Todo list item could not be deleted."
    end
    redirect_to todo_list_todo_items_path
  end

  def complete
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to todo_list_todo_items_path, notice: "Todo item marked as complete."
  end

  # In order not have to type todo_list everytime inside the controller and view
  # Every single time it's looking for to do list ID.
  # We can give it the ID of the to do list because we already have it.
  # Every single time it generates a URL for us, that will be called.
  def url_options
    { todo_list_id: params[:todo_list_id] }.merge(super)
  end

  # this is important when using todo_items_params in create method to avoid error from rails
  # this is called strong parameters:
  # With strong parameters, Action Controller parameters are forbidden to be used in Active Model mass assignments until they have been whitelisted. This means that you'll have to make a conscious decision about which attributes to allow for mass update. This is a better security practice to help prevent accidentally allowing users to update sensitive model attributes.
  # this tells rails what is ok to work with and what it can modify
  private
  def find_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
