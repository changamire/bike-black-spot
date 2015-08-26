require 'mail'
require 'erb'
require 'ostruct'

class Mailer

  Mail.defaults do
    if ENV['RACK_ENV'] == 'qa'
      delivery_method :smtp, :user_name => '395687e8aada05c69',
                      :password => '5a507cd7412e26',
                      :address => 'mailtrap.io',
                      :domain => 'mailtap.io',
                      :port => '2525',
                      :authentication => :cram_md5

    elsif ENV['RACK_ENV'] == 'production'
      delivery_method :smtp, :user_name => ENV['SENDGRID_USERNAME'],
                      :password => ENV['SENDGRID_PASSWORD'],
                      :address => 'smtp.sendgrid.net',
                      :domain => 'bikeblackspot.org',
                      :port => '587',
                      :authentication => :plain,
                      :enable_starttls_auto => true
    else
      delivery_method :smtp, address: 'localhost', port: 1025
    end
  end

  @confirmation_email = ENV['CONFIRMATION_ADDRESS'] || 'confirmation-test@test.com'

  @reports_email = ENV['REPORTS_ADDRESS'] || 'reports-test'

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
        from: @confirmation_email,
        subject: "Welcome #{user.name} to Bike Blackspot!",
        content_type: 'text/html; charset=UTF-8',
        body: erb
    )
    mail.deliver
  end

  def self.send_reports(report)
    begin
      self.send_user_report(report)
    rescue Net::SMTPUnknownError
      puts 'Send user email failed'
    end
    begin
      self.send_state_report(report)
    rescue Net::SMTPUnknownError
      puts 'Send state email failed'
    end
  end

  def self.send_state_report(report)
    namespace = generate_report(report)
    erb = generate_erb(namespace, 'app/views/emails/state.erb')

    mail_list = []
    recipients = Recipient.where(state: report.location.state)

    recipients.each do |recipient|
      mail_list << Mail.new(
          to: recipient.email,
          reply_to: report.user.email,
          cc: 'reports@bikeblackspot.org',
          from: generate_from_email,
          subject: "Bike Blackspot Report for #{report.location.formatted_address}",
          content_type: 'text/html; charset=UTF-8',
          body: erb
      )
    end

    mail_list.each do |mail|
      mail.deliver
      report.sent_at = Time.now
      report.save!
    end
  end

  def self.send_user_report(report)
    namespace = generate_report(report)
    erb = generate_erb(namespace, 'app/views/emails/user.erb')

    mail = Mail.new(
        to: report.user.email,
        from: generate_from_email,
        cc: 'reports@bikeblackspot.org',
        subject: "Bike Blackspot Report for #{report.location.formatted_address}",
        content_type: 'text/html; charset=UTF-8',
        body: erb
    )
    mail.deliver

  end

  def self.generate_report(report)
    location = report.location
    google_map = generate_static_google_map(location.lat, location.long, 14, '580x313', 2)
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

  def self.generate_from_email
    "#{@reports_email}+#{sprintf('%010d', rand(10**10))}@bikeblackspot.org"
  end
end

def generate_static_google_map(lat, long, zoom, size, scale)
  "https://maps.googleapis.com/maps/api/staticmap?center=#{lat},#{long}&zoom=#{zoom}&size=#{size}&scale=#{scale}&markers=color:black%7Clabel:%7C#{lat},#{long}"
end
