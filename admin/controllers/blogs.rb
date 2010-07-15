Admin.controllers :blogs do

  get :index do
    @blogs = Blog.all
    render 'blogs/index'
  end

  get :new do
    @blog = Blog.new
    render 'blogs/new'
  end

  post :create do
    @blog = Blog.new(params[:blog])
    if @blog.save
      flash[:notice] = 'Blog was successfully created.'
      redirect url(:blogs, :edit, :id => @blog.id)
    else
      render 'blogs/new'
    end
  end

  get :edit, :with => :id do
    @blog = Blog.find(params[:id])
    render 'blogs/edit'
  end

  put :update, :with => :id do
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      flash[:notice] = 'Blog was successfully updated.'
      redirect url(:blogs, :edit, :id => @blog.id)
    else
      render 'blogs/edit'
    end
  end

  delete :destroy, :with => :id do
    blog = Blog.find(params[:id])
    if blog.destroy
      flash[:notice] = 'Blog was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Blog!'
    end
    redirect url(:blogs, :index)
  end
end