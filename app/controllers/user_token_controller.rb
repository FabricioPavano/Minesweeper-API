class UserTokenController < Knock::AuthTokenController

	# TODO load CSRF Token in game creation form
	# skip_before_action :verify_authenticity_token

end
