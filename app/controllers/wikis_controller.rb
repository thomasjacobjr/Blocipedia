class WikisController < ApplicationController
  def index
    if current_user.premium? || current_user.admin?
      @wikis = Wiki.all
    else
      @wikis = Wiki.where(["private = ?", false ])
    end
  end

  def show
    @wiki = Wiki.find(params[:id])

    authorize @wiki
  end

  def new
    @wiki = Wiki.new

    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again later."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])

    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])

    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    @wiki.update_attribute(:private, params[:wiki][:private])

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

end
