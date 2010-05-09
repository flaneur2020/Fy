class UploadController < ApplicationController

  def index
    redirect_to :action => :add
  end

  def list
  end

  # add an image here
  def add
  end

  def create
    @upload = Upload.new(params[:upload])
    if request.post?
      if @upload.save 
        flash[:notice] = 'uploaded successfully'
        redirect_to :action => :list
      else
        flash[:errors] = @upload.errors
        render :action => :add
      end
    end
  end

  # edit info on image
  def edit
  end

  def save
  end

  def rm
  end

end
