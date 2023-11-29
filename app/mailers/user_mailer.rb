class UserMailer < ApplicationMailer
  default from: 'the-chaton-project@hotmail.com'

  def welcome_email(user)
    @user = user

    @url = 'https://the-kitten-project-924e8cb48f6e.herokuapp.com/login'

    mail(to: @user.email, subject: 'Bienvenue sur The Chaton Project 😺 ')
  end
end