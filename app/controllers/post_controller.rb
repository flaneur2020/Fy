class PostController < ApplicationController
  def list
    @posts = Post.find(:all)
  end
  def add
    if request.post?
      # blah~
      @post = Post.create(params[:post])
      redirect_to :action => :edit,
                  :id     => @post.id
    end
  end
  def edit
    @post = Post.find(params[:id])
    if request.post?
      @post = Post.find(params[:id])
      #@post.update(params[:post])
      redirect_to :action => :edit,
                  :id     => @post.id
    end
  end
  def rm
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :action => :list
  end
end
