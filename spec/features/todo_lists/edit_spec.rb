require 'spec_helper'

describe "Editing todo lists" do
  # let! is an RSpec feature that lets you assign a value to a variable
  # In this case, it creates a variable :todo_list and assign it to a Todo list value
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.") }

  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list."

    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title] 
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates a todo list successfully with correct information" do
    update_todo_list todo_list: todo_list, 
                     title: "New title", 
                     description: "New description"

    # it is important to reload database for the test to pass
    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated.")
    expect(todo_list.title).to eq("New title")
    expect(todo_list.description).to eq("New description")
  end

  it "displays an error with no title" do
    update_todo_list todo_list: todo_list, title: ""
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error with too short a title" do
    update_todo_list todo_list: todo_list, title: "hi"
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error with no description" do
    update_todo_list todo_list: todo_list, description: ""
    description = todo_list.description
    todo_list.reload
    expect(todo_list.description).to eq(description)
    expect(page).to have_content("error")
  end

  it "displays an error with too short a description" do
    update_todo_list todo_list: todo_list, description: "hi"
    description = todo_list.description
    todo_list.reload
    expect(todo_list.description).to eq(description)
    expect(page).to have_content("error")
  end
end