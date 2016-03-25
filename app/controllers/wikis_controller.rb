class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

    # TODO - investigate how to call html_safe from controller
    @wiki.title = markdown.render(@wiki.title)
    @wiki.body = markdown.render(@wiki.body)
  end

  def new
    @wiki = Wiki.new

    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    unless current_user.nil?
      @wiki.user_id = current_user.id
    end

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
    @wiki.private = params[:wiki][:private]

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
