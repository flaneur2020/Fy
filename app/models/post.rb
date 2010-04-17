class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  # validations 
  validates_presence_of :title, 
                        :user
end
