class UploadController < ApplicationController

  def index
    redirect_to :action => :add
  end

  def list
    @uploads = Upload.find(:all, :order=>'updated_at desc')
  end

  # add an image here
  def add
    @upload = Upload.new(params[:upload])
    @upload.user = current_user
    @upload.post_id = params[:post_id]
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
    @upload = Upload.find(params[:id])
    if @upload.destroy
      flash[:notice] = 'removed successfully'
      redirect_to :action => :list
    else
      flash[:errors] = @upload.errors
      redirect_to :action => :list
    end
  end

end
