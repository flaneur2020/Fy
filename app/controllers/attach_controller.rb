class AttachController < ApplicationController
  layout 'attach'

  #TODO: must have a post_id
  # before_filter

  def index
    redirect_to :new
  end

  def list_all
    @attaches = Attach.find(:all, 
                            :order=>'updated_at desc')
    render :action => :list
  end

  def list
    @attaches = Attach.find(:all, 
                            :conditions => ['post_id=?', params[:post_id]],
                            :order=>'updated_at desc')
    render :action => :list
  end

  # add an image here
  def new
    @post = Post.find(params[:post_id])
    @attach = Attach.new
  end

  def save
    @attach = Attach.new(params[:attach])
    @attach.user = current_user
    if @attach.save 
      flash[:notice] = 'uploaded successfully'
      redirect_to attach_url(:list, :post_id => @attach.post_id)
    else
      flash[:errors] = @attach.errors
      redirect_to attach_url(:new,  :post_id => @attach.post_id)
    end
  end

  def destroy
    @attach = Attach.find(params[:id])
    post_id = @attach.post_id
    if @attach.destroy
      flash[:notice] = 'removed successfully'
      redirect_to attach_url(:list, :post_id => post_id)
    else
      flash[:errors] = @attach.errors
      redirect_to :action => :list
    end
  end

end
