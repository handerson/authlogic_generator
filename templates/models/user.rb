class <%=class_name%> < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Mailer.deliver_password_reset_instructions(self)
  end
  
  def confirm!
    self.state = "confirmed"
    if self.reset_perishable_token!     
      true
    else
      false
    end
  end
  
  def confirmed?
    if self.state == "confirmed"
      true
    else
      false
    end
  end
end
