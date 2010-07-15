Admin.controllers :posts do

  get :index do
    @posts = Post.all
    render 'posts/index'
  end

  get :new do
    @accounts = Account.all
    @blogs = Blog.all
    @post = Post.new
    render 'posts/new'
  end

  post :create do
    params[:post][:body]
    @post = Post.new(params[:post])
    if @post.save
     flash[:notice] = 'Post was successfully created.'
     redirect url(:posts, :edit, :id => @post.id)
    else
     @accounts = Account.all
     @blogs = Blog.all
     render 'posts/new'
    end
  end

  get :edit, :with => :id do
    @accounts = Account.all
    @blogs = Blog.all
    @post = Post.find(params[:id])
    render 'posts/edit'
  end

  put :update, :with => :id do
    pp params[:post][:body]
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
     flash[:notice] = 'Post was successfully updated.'
     redirect url(:posts, :edit, :id => @post.id)
    else
     render 'posts/edit'
    end
  end

  delete :destroy, :with => :id do
    post = Post.find(params[:id])
    if post.destroy
      flash[:notice] = 'Post was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Post!'
    end
    redirect url(:posts, :index)
  end
end