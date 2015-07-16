require 'mail'

class Mailer

  #TODO: Find elegant way to change config based on environment
  Mail.defaults do
    if ENV['RACK_ENV'] == 'production'
      delivery_method :smtp, :user_name => '395687e8aada05c69',
                             :password => '5a507cd7412e26',
                             :address => 'mailtrap.io',
                             :domain => 'mailtap.io',
                             :port => '2525',
                             :authentication => :cram_md5
    else
      delivery_method :smtp, address: 'localhost', port: 1025
    end
  end

  def self.send_confirmation(user)

    @user = user
    @confirmation = Confirmation.find_by(user: @user.uuid)

    @server = ENV['server']
    @server = 'localhost:4567' if @server.nil?
    @link = "http://#{@server}/users/confirm?token=#{@confirmation.token}"

    @mail = Mail.new(
        to: @user.email,
        from: 'somebody@greens.com',
        subject: "Welcome #{@user.name} to Bike Black Spot!",
        body: "Please follow the link to confirm your device: <a href='#{@link}' target=\"_blank\">#{@confirmation.token}</a>"
    )
    @mail.deliver
  end
end
