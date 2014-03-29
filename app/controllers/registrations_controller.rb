class RegistrationsController < Devise::RegistrationsController
  def new
    @email = params[:email]
    if @email.nil?
    	flash[:notice] = "you cannot register on this site! please tell present user who is your friend to invite you :P."
    	redirect_to root_path
    else
    	@email = Base64::decode64(@email)
    	super
  	end
  end

  def create
    super
  end

  def update
    super
  end
end