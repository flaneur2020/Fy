class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  # validations 
  validates_presence_of   :user
  validates_presence_of   :title,
                          :message => ' can not be blank'
  validates_inclusion_of  :state,
                          :in => %w{draft published removed},
                          :message => ' can just in %w{draft published removed}'

  def remove
    self.state = 'removed'
  end

  def publish
    self.state = 'published'
  end

end
