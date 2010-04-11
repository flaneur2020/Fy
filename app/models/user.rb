class User < ActiveRecord::Base
  has_one :role

  # consts on ROLE
  RROOT     = 0
  RVISITOR  = 1
  RUSER     = 2

  def self.login(user)
    name = user[:name]
    pass = user[:pass]
    user = User.find_by_name_and_pass(name, pass)
    # TODO here set cookie and blah~
    if user
      @@current = user 
    end
    return user
  end
  def self.current
    @@current || self.visitor
  end
  def self.visitor
    nil
  end
  
  def can(name)
  end
  def login?
  end
end
