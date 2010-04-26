class Category < ActiveRecord::Base
  acts_as_tree 

  has_many :posts
  
  # validations
  validates_presence_of :name
  validates_uniqueness_of :name
  # TODO: valid do not set parent as self

  # the roots' parents are nil
  # TODO: get depth when traverse
  # have a cache
  def depth
    return @depth if @depth
    r = 0
    c = self
    while c = c.parent
      r += 1
    end
    return @depth = r
  end 

  def Category.as_list(root=nil, r=[])
    if root
      r << root
      root.children.each do |c|
        Category.as_list(c, r)
      end
    else
      r = []
      Category.find_roots.each do |c|
        Category.as_list(c, r)
      end
    end
    return r
  end

  # just a helper
  def Category.find_or_new(*args)
    return Category.find(*args)
  rescue
    return Category.new
  end

  def Category.find_roots
    Category.find_all_by_parent_id(nil)
  end

end
