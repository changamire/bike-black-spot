class Admin < ActiveRecord::Base

  def authenticate(supplied_password)
    self.password == supplied_password
  end
end