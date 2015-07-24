require 'mail'
require 'erb'
require 'ostruct'

class Mailer

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

    user = user
    confirmation = Confirmation.find_by(user: user.uuid)
    server = ENV['server'] || 'localhost:4567'
    confirmation_link = "http://#{server}/users/confirm?token=#{confirmation.token}"

    namespace = OpenStruct.new(
                              confirmation_link: confirmation_link
    )

    template = File.read('app/views/emails/confirm.erb')
    erb = ERB.new(template).result(namespace.instance_eval { binding })
    mail = Mail.new(
        to: user.email,
        from: 'bikeblackspot@gmail.com',
        subject: "Welcome #{user.name} to Bike Black Spot!",
        content_type: 'text/html; charset=UTF-8',
        body: erb
    )
    mail.deliver
  end

  def self.send_report(report)

    report = report
    user = User.find(report.user.id)
    location = Location.find(report.location_id)
    category = Category.find(report.category.id)
    recipients = Recipient.where(state: location.state)
    google_map = generate_static_google_map(location.lat, location.long, 14, '475x200', 2)

    namespace = OpenStruct.new(
                               address: location.formatted_address,
                               description: report.description,
                               google_map: google_map,
                               date: Time.now.strftime('%d/%m/%Y'),
                               name: user.name,
                               photo: report.image,
                               title: category.name
                              )

    template = File.read('app/views/emails/state.erb')
    erb = ERB.new(template).result(namespace.instance_eval { binding })

    mail_list = []
    recipients.each do |recipient|
      mail_list << Mail.new(
          to: recipient.email,
          from: 'bikeblackspot@gmail.com',
          subject: "Bike Black Spot Report for #{location.formatted_address}",
          content_type: 'text/html; charset=UTF-8',
          body: erb
      )
    end

    mail_list.each do |mail|
      mail.deliver
    end
  end
end

private
def generate_static_google_map(lat, long, zoom, size, scale)
  "https://maps.googleapis.com/maps/api/staticmap?
        center=#{lat},#{long}
        &zoom=#{zoom}
        &size=#{size}
        &scale=#{scale}
        &markers=color:black%7Clabel:%7C#{lat},#{long}"
end