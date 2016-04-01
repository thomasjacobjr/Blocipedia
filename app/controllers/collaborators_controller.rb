class CollaboratorsController < ApplicationController

  def destroy
    @user = User.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])

    authorize @wiki 

    if @wiki.collaborators.delete(@user)
      flash[:notice] = "\"#{@user.email}\" was deleted successfully."
      redirect_to wiki_path(@wiki)
    else
      flash.now[:alert] = "There was an error removing the collaborator."
      render :show
    end
  end

end
