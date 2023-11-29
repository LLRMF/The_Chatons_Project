class UserMailer < ApplicationMailer
  default from: 'no-reply@the-chaton-project.fr'

  def welcome_email(user)
    @user = user

    @url = 'http://....../users/sign_up'

    mail(to: @user.email, subject: 'Bienvenue sur The Chaton Project 😺 ')
  end
end