module RailsDomIdHelper
  # this is to replace the code in todo_list_helpers
  # from within("#todo_item_#{todo_item.id}") 
  # to within dom_id_for(list)
  def dom_id_for(model)
    ["#", ActionView::RecordIdentifier.dom_id(model)].join
  end
end