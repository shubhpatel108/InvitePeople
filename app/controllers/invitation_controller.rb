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
		begin
			if User.verify_email_token(@email, @token)
				logger.info("Success")
				redirect_to new_user_registration_path(:email => @email)
			else
				redirect_to root_path
			end
		rescue
			flash[:notice] = "Invalid or corrupted token"
			redirect_to root_path
		end
	end

	def request_admin
		email = params[:email]
		if email.empty?
			flash[:notice] = "Please enter email address"
			redirect_to root_path
		else
			InvitationMailer.request_admin_mail(email).deliver
			flash[:notice] = "Your request will soon be entertained."
			redirect_to root_path
		end
	end
end