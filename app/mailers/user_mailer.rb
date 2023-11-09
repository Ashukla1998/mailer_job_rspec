class UserMailer < ApplicationMailer
    default from: 'shuklaashu134@gmail.com'
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Welcome to Your App Name')
    end
end