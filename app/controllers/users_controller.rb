class UsersController < ApplicationController

	# TODO load CSRF Token in game creation form
	skip_before_action :verify_authenticity_token

	# POST /user
	# POST /user.json
	def create

	  @user = User.new(user_params)

	  respond_to do |format|
	    if @user.save
	      format.html { redirect_to @user, notice: 'user was successfully created.' }
	      format.json { render :show, status: :created, location: @user }
	    else
	      format.html { render :new }
	      format.json { render json: @user.errors, status: :unprocessable_entity }
	    end
	  end
	end



	private

		# Only allow a list of trusted parameters through.
		def user_params
		  params
		    .require(:user)
		    .permit(:email,
		            :password)
		end
end
