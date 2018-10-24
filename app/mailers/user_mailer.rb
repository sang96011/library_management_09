class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #

  def create_request user_id
      @user = User.find(user_id)
      mail(to:  @user.email, subject: "Create Your Request" )
  end

  def accept_request user_id
      @user = User.find(user_id)
      mail(to:  @user.email, subject: "Accept Your Request" )
  end

  def reject_request user_id
      @user = User.find(user_id)
      mail(to:  @user.email, subject: "Reject Your Request" )
  end

  def delete_request user_id
      @user = User.find(user_id)
      mail(to:  @user.email, subject: "Delete Your Request" )
  end
end
