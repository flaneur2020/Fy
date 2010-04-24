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

  def state=(str)
    if ['draft', 'published', 'removed'].include?(str)
      super(str)
    else
      raise 'state of a Post is just "draft", "published" and "removed"'
    end
  end

end
