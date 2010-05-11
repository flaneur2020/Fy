require 'forwardable.rb' 

class Upload < ActiveRecord::Base
  extend Forwardable

  belongs_to :post
  belongs_to :user

  validates_presence_of :user

  # for plugin Paperclip
  has_attached_file :attach,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :url => "/uploads/:attachment/:id/:style_:basename.:extension"

  def_delegators :attach, :url, :size

  def basename
  end

end
