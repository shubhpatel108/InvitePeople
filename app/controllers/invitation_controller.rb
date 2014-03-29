class InvitationController < ApplicationController

	def invite_people
	end

	def send_invitation
		email = params[:invitee_email]
		token = User.create_token(email)
		InvitationMailer.send_invitation_mail(email, token).deliver
		redirect_to root_path
	end

	def verify_request
		@email = params[:email]
		@token = params[:token]
		if User.verify_email_token(@email, @token)
			logger.info("Success")
			redirect_to new_user_registration_path(:email => @email)
		else
			redirect_to root_path
		end
	end
end