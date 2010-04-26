class PostController < ApplicationController
  before_filter :check_login

  def index
    redirect_to :action => :list
  end

  def preview
  end

  # TODO: added rescue for find
  def list
    # filters
    cond = {} 
    cond[:category_id] = Category.find_by_name(params[:category]).id  if params[:category]
    cond[:user_id]     = User.    find_by_name(params[:user]).id      if params[:user]
    # by default, do not display the removed
    cond[:state] = ['published', 'draft']
    cond[:state] = params[:state] if params[:state]

    page = params[:page] || 1
    @posts = Post.paginate(:all, 
                           :page=>page,
                           :conditions=>cond, 
                           :order=>'id desc', 
                           :per_page=>20)
  end

  # add posts to draft
  # check the tag of publishment
  def add
    @post = Post.new
    render :action => :edit
  end

  def edit
    @post = Post.find(params[:id])
    render :action => :edit
  end

  # add, eidt => save 
  # if title in form is '', make it "(untitled)"
  def save
    @post = Post.find_or_new(params[:id])
    if request.post?
      @post.attributes = params[:post]
      # TODO: one author, serveral eitors
      @post.user = current_user
      @post.title = '(untitled)' if @post.title.strip==''
      @post.category = Category.find_by_name(params[:category])
      if @post.save
        flash[:notice] = 'saved successfully'
        redirect_to :action => :edit,
          :id     => @post.id
      else
        flash[:errors] = @post.errors
        render :action => :edit
      end
    end
  end

  # just tag post as published, just a tag
  def publish
    @post = Post.find(params[:id])
    @post.state = 'published'
    if @post.save
      flash[:notice] = "published successfully"
      # merge :id into params
      redirect_to params.merge(:action => :edit)
    end
  end

  # just tag post as removed
  def rm
    @post = Post.find(params[:id])
    @post.state = 'removed'
    if @post.save
      flash[:notice] = "the post '#{@post.title}' have been removed into recycle bin"
      redirect_to params.merge(:action => :list)
    end
  end

  def recover
    @post = Post.find(params[:id])
    @post.state = 'draft'
    if @post.save
      flash[:notice] = "the post '#{@post.title}' been recovered as a draft. "
      redirect_to params.merge(:action => :list)
    end
  end

  # do REAL deletion
  def del
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "the post '#{@post.title}' have been deleted"
      redirect_to :action => :list, :state=>:removed
    end
  end
end
