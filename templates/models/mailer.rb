class Mailer < ActionMailer::Base
  if RAILS_ENV == "development"
    default_url_options[:host] = "localhost:3000"
  elsif RAILS_ENV == "testing"
    default_url_options[:host] = "testing.project.blacksnowlabs.com"
  elsif RAILS_ENV == "staging"
    default_url_options[:host] = "staging.project.blacksnowlabs.com"
  elsif RAILS_ENV == "production"
    default_url_options[:host] = "example.com/"
  end
  
  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "Admin <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  def confirmation(user)
    subject       "Account Confirmation"
    from          "Admin <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :confirmation_url => "http://#{default_url_options[:host]}/confirm/#{user.perishable_token}"
  end
  
end
