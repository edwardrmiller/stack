class LinksController < ApplicationController
  
  # before EVERYTHING in here, find the category
  before_action :get_category

  # before EDIT UPDATE, and DESTROY, find the link
  before_action :get_link, only: [:edit, :update, :destroy]
  

  def new
    if params[:duplicate_id].present?
      # do a duplicate of this 
      @link = @category.links.find(params[:duplicate_id])
    else
      # do a brand new one
      @link = @category.links.new
    end
  end


  def create
  	@link = @category.links.new()

  	if @link.save
  		flash[:success] = "Link added"
  		redirect_to category_path(@category)
  	else
  		render "new"
  	end

  end


  def edit
    # @link = @category.links.find(params[:id])
  end

  def update
    # @link = @category.links.find(params[:id])

    if @link.update(link_params)
      flash[:success] = "Link was updated"
      redirect_to category_path(@category)
    else
      render :edit
    end

  end


  def destroy
    # @link = @category.links.find(params[:id])
    @link.destroy
    flash[:success] = "Link was deleted"
    redirect_to category_path(@category)
  end



  def link_params
  	params. require(:link).permit(:name, :description, :url)
  end

  def get_category
  	# because we're not in the categories controller, we need to find the id of the category
  	# using the /categories/:category_id/links/new
  	@category = Category.find(params[:category_id])
  end


  def get_link
    @link = @category.links.find(params[:id])
  end

end
