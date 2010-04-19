class Category < ActiveRecord::Base
  has_many :posts
  
  # validations
  validates_uniqueness_of :name

  def Category.to_options(root='')
    r=[]
    Category.find(:all).each{|c| 
      r << c.name
    }
    return r
  end
end
