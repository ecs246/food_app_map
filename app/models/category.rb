class Category < ActiveRecord::Base
    before_destroy :reassign_subcategories
    has_many :sub_categories, :class_name => "Category", 
      :foreign_key => "parent_id", :order => 'name'
    belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"

      
    default_scope :include => :sub_categories
    scope :sub_categories_from, lambda { |ids|
      where("categories.parent_id in (#{ids})", ids)
    }
   
    validates :name, :presence => true
    validate :parent_cannot_be_the_same_as_self_or_child
    

    
    def parents_array 
      arr = []
      p = parent_category
      while !p.nil? do
        arr << p
        p = p.parent_category
      end 
      arr
    end
  
    private 
      def reassign_subcategories 
        sub_categories.each do |category|
          category.parent_id = parent_id
          category.save
        end
      end
     def parent_cannot_be_the_same_as_self_or_child
      if !id.nil? && parent_id == id
          errors.add(:parent_id,"can't be the same as Current")
      end
    end
end
