class CustomerMailer < ApplicationMailer
    default :from => "officialgroceryguru@gmail.com"
    
    layout 'mailer'

    def mailer(email, name, data)
        @name = name
        @body = data
        mail(to: 'officialgroceryguru@gmail.com', subject: "FROM: " + email)
    end
end
