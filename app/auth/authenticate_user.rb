class AuthenticateUser
  attr_reader :email, :password, :doctor
  
  def initialize(email, password)
    @user = User.find_by(email: email)
    @email = email
    @password = password
    @doctor = @user.doctor
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  # verify user credentials
  def user
    return @user if @user && @user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end