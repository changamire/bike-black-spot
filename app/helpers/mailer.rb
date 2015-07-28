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

  def self.send_reports(report)
    self.send_state_report(report)
    self.send_user_report(report)
  end

  def self.send_state_report(report)
    namespace = generate_report(report)
    erb = generate_erb(namespace, 'app/views/emails/state.erb')

    mail_list = []
    recipients = Recipient.where(state: report.location.state)

    recipients.each do |recipient|
      mail_list << Mail.new(
          to: recipient.email,
          from: 'bikeblackspot@gmail.com',
          subject: "Bike Black Spot Report for #{report.location.formatted_address}",
          content_type: 'text/html; charset=UTF-8',
          body: erb
      )
    end


    mail_list.each do |mail|
      mail.deliver
    end

    report.sent_at = Time.now
    report.save!

    return mail_list
  end


  def self.send_user_report(report)
    namespace = generate_report(report)
    erb = generate_erb(namespace, 'app/views/emails/user.erb')

    mail = Mail.new(
        to: report.user.email,
        from: 'bikeblackspot@gmail.com',
        subject: "Bike Black Spot Report for #{report.location.formatted_address}",
        content_type: 'text/html; charset=UTF-8',
        body: erb
    )
    mail.deliver

  end

  def self.generate_report(report)
    location = report.location
    google_map = generate_static_google_map(location.lat, location.long, 14, '475x200', 2)
    return OpenStruct.new(
        address: location.formatted_address,
        description: report.description,
        google_map: google_map,
        date: Time.now.strftime('%d/%m/%Y'),
        name: report.user.name,
        photo: report.image,
        title: report.category.name
    )
  end

  def self.generate_erb(namespace, templateFile)
    template = File.read(templateFile)
    ERB.new(template).result(namespace.instance_eval { binding })
  end
end

def generate_static_google_map(lat, long, zoom, size, scale)
  "https://maps.googleapis.com/maps/api/staticmap?
        center=#{lat},#{long}
        &zoom=#{zoom}
        &size=#{size}
        &scale=#{scale}
        &markers=color:black%7Clabel:%7C#{lat},#{long}"
end