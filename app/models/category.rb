class Category < ActiveRecord::Base
  acts_as_tree :order => :created_at

  has_many :posts
  
  # validations
  validates_presence_of :name
  validates_uniqueness_of :name

  validate do |cate|
    if cate.parent == cate
      cate.errors.add(:category, ' can not set self as parent')
    end
  end

  # TODO: the first category cannot be destoryed

  # TODO: valid do not set parent as self

  def depth
    self.ancestors.size
  end 

  def Category.as_list(root=nil, r=[])
    if root
      r << root
      root.children.each do |c|
        Category.as_list(c, r)
      end
    else
      r = []
      Category.roots.each do |c|
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

end
