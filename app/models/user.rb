class User < ActiveRecord::Base
  has_many :posts

  def self.login(name, pass)
    user = User.find_by_name(name)
    if user && user.pass == pass
      return user
    end
    return nil
  end

  def can(name)
  end
end
