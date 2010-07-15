Admin.controllers :blog_rolls do

  get :index do
    @blog_rolls = BlogRoll.all
    render 'blog_rolls/index'
  end

  get :new do
    @blog_roll = BlogRoll.new
    render 'blog_rolls/new'
  end

  post :create do
    @blog_roll = BlogRoll.new(params[:blog_roll])
    if @blog_roll.save
      flash[:notice] = 'BlogRoll was successfully created.'
      redirect url(:blog_rolls, :edit, :id => @blog_roll.id)
    else
      render 'blog_rolls/new'
    end
  end

  get :edit, :with => :id do
    @blog_roll = BlogRoll.find(params[:id])
    render 'blog_rolls/edit'
  end

  put :update, :with => :id do
    @blog_roll = BlogRoll.find(params[:id])
    if @blog_roll.update_attributes(params[:blog_roll])
      flash[:notice] = 'BlogRoll was successfully updated.'
      redirect url(:blog_rolls, :edit, :id => @blog_roll.id)
    else
      render 'blog_rolls/edit'
    end
  end

  delete :destroy, :with => :id do
    blog_roll = BlogRoll.find(params[:id])
    if blog_roll.destroy
      flash[:notice] = 'BlogRoll was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy BlogRoll!'
    end
    redirect url(:blog_rolls, :index)
  end
end