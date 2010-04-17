class Category < ActiveRecord::Base
  has_many :posts

  def Category.to_options
    r={}
    Category.find(:all).each{|c| 
      r[c.name]=c.id 
    }
    return r
  end
end
