class PostController < ApplicationController
  before_filter :check_login

  def index
    redirect_to :action => :add
  end

  def list
    page  = params[:page] || 1
    @posts = Post.paginate(:all, :page=>page, :per_page=>15, :order=>'id desc')
  end
  
  def add
    if request.post?
      # blah~
      @post = Post.new(params[:post])
      @post.user = current_user
      if @post.save
        flash[:notice] = 'posted successfully!'
        redirect_to :action => :edit,
                    :id     => @post.id
      else
        flash[:errors] = @post.errors
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    if request.post?
      if @post.update_attributes(params[:post])
        flash[:notice] = 'posted successfully!'
        redirect_to :action => :edit,
                    :id     => @post.id
      else 
        flash[:errors] = @post.errors
      end
    end
  end

  def rm
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "the post '#{@post.title}' have been deleted"
      redirect_to :action => :list
    else
      flash[:errors] = @post.errors
    end
  end

  #TODO: rm_many
  def rm_many
    
  end
end
