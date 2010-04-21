class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  # validations 
  validates_presence_of :title,
                        :message => ' can not be blank'

  validates_presence_of :user

  def remove
    self.state = 'removed'
  end

  def publish
    self.state = 'published'
  end

end
