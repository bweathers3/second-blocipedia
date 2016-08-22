class IntroMailer < ApplicationMailer

   default from: "bailey.g.weathers@gmail.com"

   def new_user_email(user)

    headers["Message-ID"] = "<test/@mailtrap.io>"
    headers["In-Reply-To"] = "<bailey/@mailtrap.io>"
    headers["References"] = "<new member/@mailtrap.io>"

    @user = user

    mail(to: user.email, subject: "Your new account is ready with Blocipedia")

  end

end
