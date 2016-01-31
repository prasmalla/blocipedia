class WikisController < ApplicationController
  
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = current_user.wikis.new
  end

  def create
    @wiki = current_user.wikis.new(params.require(:wiki).permit(:title, :body, :private))

    if @wiki.save
      flash[:notice] = "Wiki added successfully!"
      redirect_to @wiki
    else
      flash[:error] = "Oops! please try again."
      render :new
    end
  end

  def edit
    @wiki = current_user.wikis.find(params[:id])
  end

  def update
    @wiki = current_user.wikis.find(params[:id])

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki updated successfuly!"
      redirect_to @wiki
    else
      flash[:error] = "Oops! please try again."
      render :edit
    end
  end

  def destroy
    @wiki = current_user.wikis.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki deleted successfuly!"
      redirect_to wikis_path
    else
      flash[:error] = "Oops! please try again."
      render :edit
    end
  end
end
