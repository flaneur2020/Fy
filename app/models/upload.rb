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

  # name might like "name.jpg?3289392", strip the godam '?'
  def basename
    File.basename(self.attach.url).split(/\?/)[0]
  end

end
