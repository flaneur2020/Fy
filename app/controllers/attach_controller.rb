class AttachController < ApplicationController

  def index
    redirect_to :action => :add
  end

  def list
    cond = []
    if params[:id]
      @post = Post.find(params[:id])
      cond = ["post_id=?", params[:id]]
    end
    @attaches = Attach.find(:all, 
                            :conditions => cond,
                            :order=>'updated_at desc')
  end

  # add an image here
  def add
    @attach = Attach.new
    @attach.post_id = params[:post_id]
    if request.post?
      @attach = Attach.new(params[:attach])
      @attach.user = current_user
      if @attach.save 
        flash[:notice] = 'uploaded successfully'
        redirect_to :action => :list, :post_id => @attach.post_id
      else
        flash[:errors] = @attach.errors
        render :action => :add
      end
    end
  end

  def rm
    @attach = Attach.find(params[:id])
    post_id = @attach.post_id
    if @attach.destroy
      flash[:notice] = 'removed successfully'
      redirect_to :action => :list, :post_id => post_id
    else
      flash[:errors] = @attach.errors
      redirect_to :action => :list
    end
  end

end
