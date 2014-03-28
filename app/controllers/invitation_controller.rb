class InvitationController < ApplicationController

	def invite_people
	end

	def send_invitation
		invitee_email = params[:invitee_email];
		token = "token"
		InvitationMailer.send_invitation_mail(invitee_email, token).deliver
		redirect_to root_path
	end
end