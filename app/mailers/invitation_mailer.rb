class InvitationMailer < ActionMailer::Base
  default from: 'inviteapp@examples.com'

  def send_invitation_mail(email, token)
  	@email = email
  	@encoded_email = Base64::encode64(email)
  	@token = token
  	mail(to: @email, subject: "Join Invitation site!")
  end

  def request_admin_mail(email)
  	@email = email
  	mail(to:"admin@inviteapp.com", subject: "Request for registration")
  end
end