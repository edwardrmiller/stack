class CategoriesController < ApplicationController

	# I want to run get_category before the show, edit, update, destroy
	# and I dont want to keep having to repeat the same code over and over.
	# We can use before_action to do things before any method (aka action)
	before_action :get_category, only: [:show, :edit, :update, :destroy]

	# control + forward slash adds a comment
	# step number 2 is to add in an index page
	# we want to define the index of our controller

	def index 
		# this is where all of the code for the index page lives


		# the quotes mean a string
		# a string means some data
		@username = "Edward"
		@age = 23

		# to do a list, we use an array.
		# to create an array, we use square brackets
		@categories = ["Design", "Rails", "Javascript", "Site Tools"]

		# now let's talk to the model
		@categories = Category.all.order("rank asc, name asc")

	end


	# individual page for category
	def show

		# category is now in get_category method that runs before this action

	end

	# the new form for a category

	def new
		@category = Category.new
	end

	# actually add the category using the data the form has in it
	def create
		@category = Category.new(category_params)

		if

			@category.save

			# tell the user they have deleted this category
			flash[:success] = "Category added"

				# redirect to homepage
		redirect_to root_path
	end

		else

			# if the category does NOT save
			# i want to shwo the form again but with some errors

			# we've already got the form we want to show the user
			# e.g. new.html.erb

			render "new"

		end 

		

		
		


	


	# Get a form to find this category

	def edit

		# category is in get_category

	end

	# actually update the row in the database
	def update
		# category is in get_category

		if 
			#  update based on the secure form data from below
			@category.update(category_params)

			# tell the user they have deleted this category
			flash[:success] = "Category updated"

			# redirect to the home page
			redirect_to root_path

		else

			# show the edit form if it doesn't update
			# edit.html.erb in our views
			render :edit
			
		end




	end

	# actually delete the category in the database
	def destroy
		# get category is in get_category

		# destroy that row
		@category.destroy

		# tell the user they have deleted this category
		flash[:success] = "Category deleted"

		# go back to the home page
		redirect_to root_path



	end


	# to not repeat ourselves, lets create a brand new method to simplify things
	def get_category
		# find the category, just like the show action
		@category = Category.find(params[:id])
	end



	# whitelist all of the form data
	def category_params
		params.require(:category).permit(:name, :rank)

	end


end

