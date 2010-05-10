class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :uploads

  # validations 
  validates_presence_of   :user
  validates_presence_of   :category,
                          :message => ' could not be blank'
  validates_presence_of   :title,
                          :message => ' can not be blank'
  validates_inclusion_of  :state,
                          :in => %w{draft published removed},
                          :message => ' can just in %w{draft published removed}'

  # TODO: rename it as trash
  def remove
    self.state = 'removed'
  end

  def publish
    self.state = 'published'
  end

  def Post.find_or_new(*args)
    return Post.find(*args)
  rescue 
    return Post.new()
  end

end
