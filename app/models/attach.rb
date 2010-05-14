require 'forwardable.rb' 

class Attach < ActiveRecord::Base
  extend Forwardable

  belongs_to :post
  belongs_to :user

  validates_presence_of :user

  # for plugin Paperclip
  validates_attachment_presence :upload
  has_attached_file :upload,
                    :styles => { :medium => "300x300>", :thumb => "150x150" },
                    :url => "/uploads/:attachment/:id/:basename.:style.:extension"

  def_delegators :upload, :url, :size, :content_type

  # name might like "name.jpg?3289392", strip the godam '?'
  def basename
    File.basename(self.upload.url).split(/\?/)[0]
  end

end
