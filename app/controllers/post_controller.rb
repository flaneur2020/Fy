class PostController < ApplicationController
  before_filter :check_login

  def list
    @posts = Post.find(:all, :order=>'id desc')
  end
  def add
    if request.post?
      # blah~
      @post = Post.new(params[:post])
      @post.user = current_user
      @post.save
      flash[:notice] = 'posted successfully!'
      redirect_to :action => :edit,
                  :id     => @post.id
    end
  end
  def edit
    @post = Post.find(params[:id])
    if request.post?
      @post = Post.find(params[:id])
      @post.update_attributes(params[:post])
      flash[:notice] = 'posted successfully!'
      redirect_to :action => :edit,
                  :id     => @post.id
    end
  end
  def rm
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "the post '#{@post.title}' have been deleted"
    redirect_to :action => :list
  end
end
