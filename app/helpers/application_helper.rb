module ApplicationHelper
  def get_admin_name_path(model)
    name = model.class.name.pluralize.downcase
    return "/admin/#{name}" 
    
    #if @model.id != nil 
 
  end
end
