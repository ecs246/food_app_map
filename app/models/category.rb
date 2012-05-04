class Category < ActiveRecord::Base
    has_and_belongs_to_many :vendors
    before_destroy :reassign_subcategories
    has_many :sub_categories, :class_name => "Category", 
      :foreign_key => "parent_id", :order => 'name'
    belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"

      
    #default_scope :include => :sub_categories
    scope :include_sub_categories ,:include => :sub_categories
    scope :sub_categories_from, lambda { |ids|
      where("categories.parent_id in (#{ids})", ids)
    }
   
    validates :name, :presence => true
    validate :parent_cannot_be_the_same_as_self_or_descendant
    
    def self.all_leveled_descendant_array
      ret = []
      #arr = find_all_by_parent_id(nil,:order=>'name')
      arr = include_sub_categories.find_all_by_parent_id(nil,:order=>'name')
      arr.each do |cat|
          ret << [cat,0]
          ret.concat(cat.leveled_descendant_array)
      end
      ret
    end
    
    def parents_array 
      arr = []
      p = parent_category
      while !p.nil? do
        arr << p
        p = p.parent_category
      end 
      arr
    end
    
    #format 
       def sub_process_category(pcategory,level=1)
        arr = [] 
        pcategory.sub_categories.each do |category|
          arr << [category,level]
          arr.concat(sub_process_category(category,level+1))
        end
        arr
      end
    
    
    def leveled_descendant_array

      #cat = Category.include_sub_categories.find_all_by_id(id)[0]
      cat = self
      sub_process_category(cat)
    end 
    
    def ancestor_of_id?(id)
      ret=false 
      Category.find(id).parents_array.each do |cat|
        if cat.id == self.id
           ret = true
           break
        end
      end  
      ret 
    end
    
    private 
      def reassign_subcategories 
        sub_categories.each do |category|
          category.parent_id = parent_id
          category.save
        end
      end
      

     def parent_cannot_be_the_same_as_self_or_descendant
      if !id.nil? && !parent_id.nil? 
        if parent_id == id || ancestor_of_id?(parent_id)
          errors.add(:parent_id,"can't be the same as self or child")
        end  
      end
    end
end
