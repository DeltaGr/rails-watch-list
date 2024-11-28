class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: "List was successfully created."
    else
      render :new
    end
  end

  # The new action for adding a bookmark to a list
  def add_bookmark
    @list = List.find(params[:id]) # Find the list by its ID
    @bookmark = @list.bookmarks.new(bookmark_params) # Create a new bookmark associated with the list

    if @bookmark.save
      redirect_to @list, notice: "Bookmark added successfully."
    else
      render :show # Render the show view if saving fails
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  # Strong parameters for the bookmark
  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
