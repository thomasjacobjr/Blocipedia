class CollaboratorsController < ApplicationController

  def destroy
    @user = User.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])

    @collaboration = Collaboration.where(user_id: params[:id], wiki_id: params[:wiki_id]).first
    
    authorize @collaboration

    if @collaboration.destroy # or @wiki.collaborators.delete(@user)
      flash[:notice] = "\"#{@user.email}\" was deleted successfully."
      redirect_to wiki_path(@wiki)
    else
      flash.now[:alert] = "There was an error removing the collaborator."
      render :show
    end
  end

end
