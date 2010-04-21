class Category < ActiveRecord::Base
  acts_as_tree 

  has_many :posts
  
  # validations
  validates_uniqueness_of :name

  def Category.to_options(root=nil, d=0, r=[])
    if root
      r << ['. . '*d + root.name, root.name]
      root.children.each do |c|
        Category.to_options(c, d+1, r)
      end
      return r
    else
      r = []
      # find all roots
      roots=Category.find_all_by_parent_id(nil)
      roots.each do |c|
        Category.to_options(c, 0, r)
      end
      return r
    end
  end
end
