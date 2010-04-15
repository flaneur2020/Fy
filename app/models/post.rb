class Post < ActiveRecord::Base
  belongs_to :user

  # validations 
  validates_presence_of :title
  validates_presence_of :user

end
