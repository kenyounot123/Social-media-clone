class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    @url = user_url(@user)
    mail to: @user.email,
         subject: "Welcome to our social media site #{@user.name}"
  end
end
