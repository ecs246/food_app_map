module Admin::CategoriesHelper

  def sub_process_category(pcategory,level=1,&blocko)
      str = "" 
      pcategory.sub_categories.each do |category|
        #str << blocko.call(category,level)
        str << capture(category,level,&blocko)
        str << sub_process_category(category,level+1,&blocko)
      end
      raw(str)
  end
  def process_category(pcategory,&blocko)
    str = ""
     
    str =  capture(pcategory,0,&blocko)
    str << sub_process_category(pcategory,&blocko)
    raw(str)
  end 
  def get_cat_opt(category_id) 
      str = ""
      category = Category.find(category_id)
      str = process_category(category) do |cat,level|
        raw(%(<option value="#{cat.id}"> #{"-"*level} #{cat.name}</option>))
      end 
      
      return str 
  end
    
  def get_map(category_id)
           category = Category.find(category_id)
      str = process_category(category) do |cat,level|
          %(
        <tr id="tag-#{cat.id}">
          <td>#{"- " * level}#{cat.name}</td><td>#{cat.id}</td>
        </tr>
      )
      end 
      return str     
  end  
    
  
end  