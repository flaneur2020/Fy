class PostsController < ApplicationController
  before_filter :check_login

  # try the egghurting Restful
  # 
  # posts
  # posts/10
  # posts/10/new
  # posts/10/create
  # posts/10/edit
  # posts/10/update
  # #
  #
  #
  def index
    list
  end

  def list
    # filters
    cond = {} 
    cond[:category_id] = Category.find_by_name(params[:category]).id  if params[:category]  rescue ''
    cond[:user_id]     = User.    find_by_name(params[:user]).id      if params[:user]      rescue ''
    # by default, do not display the removed
    cond[:state] = ['published', 'draft']
    cond[:state] = params[:state] if params[:state]

    page = params[:page] || 1
    @posts = Post.paginate(:all, 
                           :page=>page,
                           :conditions=>cond, 
                           :order=>'updated_at desc', 
                           :per_page=>20)

    render :action => :list
  end

  # preview
  def show
  end

  def new
    @post = Post.new
    render :action => :edit
  end

  def edit
    @post = Post.find(params[:id])
    render :action => :edit
  end

  def create
    save
  end
  
  def update
    save
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "the post '#{@post.title}' have been deleted"
      redirect_to posts_url(:state=>:removed)
    end
  end

  # just tag it as 'removed'
  def trash
    @post = Post.find(params[:id])
    @post.state = 'removed'
    if @post.save
      flash[:notice] = "the post have been trashed"
    else
      flash[:errors] = @post.errors
    end
    redirect_to params.merge(:action => :list)
  end

  def restore
    @post = Post.find(params[:id])
    @post.state = 'draft'
    if @post.save
      flash[:notice] = "the post have been restored"
    else
      flash[:errors] = @post.errors
    end
    redirect_to params.merge(:action => :list)
  end

  # just tag post as published, just a tag
  def publish
    @post = Post.find(params[:id])
    @post.state = 'published'
    if @post.save
      flash[:notice] = "published successfully"
      # merge :id into params
      redirect_to edit_post_url(@post)
    end
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

end
