module CategoryHelper
  
  # default is the name of of category as default
  def fy_category_select_tag(name=:category, default=nil)
    options = [['--------------', nil]] + fy_category_to_options
    select_tag name, options_for_select(options, default)
  end

  def fy_category_to_options()
    Category.as_list.map do |cate|
      [' . . '*cate.depth+cate.name, cate.name]
    end
  end

end
