class CollaborationsController < ApplicationController 
  before_action :set_wiki

  def create
    @collaborator = Collaboration.new(wiki_id: @wiki.id, user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "Collaborator added sucessfully!"
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error updating your wiki. Please try again."
      render :new
    end
  end

  def destroy
    @collaborator = Collaboration.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator removed!"
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error. Please try again."
      render :show
    end
  end

private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

end