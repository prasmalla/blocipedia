class WikisController < ApplicationController

  before_filter :authorize_wiki, only: [:edit, :update, :destroy]
  
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    redirect_to @wiki, status: :moved_permanently if request.path != wiki_path(@wiki)
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki added successfully!"
      redirect_to @wiki
    else
      flash[:error] = "Oops! please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
  end

  def update
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki updated successfuly!"
      redirect_to @wiki
    else
      flash[:error] = "Oops! please try again."
      render :edit
    end
  end

  def destroy
    if @wiki.destroy
      flash[:notice] = "Wiki deleted successfuly!"
      redirect_to wikis_path
    else
      flash[:error] = "Oops! please try again."
      render :edit
    end
  end

  private 

  def authorize_wiki
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
end
