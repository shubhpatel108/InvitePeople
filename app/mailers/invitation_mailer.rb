class InvitationMailer < ActionMailer::Base
  default from: 'inviteapp@examples.com'

  def send_invitation_mail(email, token)
  	@email = email
  	@token = token
  	mail(to: @email, subject: "Join Invitation site!")
  end
end