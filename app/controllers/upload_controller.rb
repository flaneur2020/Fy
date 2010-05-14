class UploadController < ApplicationController

  def index
    redirect_to :action => :add
  end

  def list
    cond = []
    cond = ['post_id', params[:post_id]] if params[:post_id]
    @uploads = Upload.find(:all, 
                           :conditions=> cond,
                           :order=>'updated_at desc')
  end

  # add an image here
  def add
    @upload = Upload.new(params[:upload])
    @upload.user = current_user
    @upload.post = Post.find(params[:post_id])
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
