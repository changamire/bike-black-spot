class Admin < ActiveRecord::Base
  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end
