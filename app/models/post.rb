class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  # validations 
  validates_presence_of :title, 
                        :user

  def remove
    self.state = 'removed'
  end

  def publish
    self.state = 'published'
  end

end
