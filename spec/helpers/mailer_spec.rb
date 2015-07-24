require 'ostruct'
require_relative '../spec_helper'
require_relative '../../app/helpers/mailer'

describe 'Mailer' do
  include Mail::Matchers

  Mail.defaults do
    delivery_method :test
  end

  describe 'send_confirmation' do

    before(:each) do
      @user = User.create(
          name: 'Harry Potter',
          email: 'hpottz@hogwarts.com'
      )
      Mail::TestMailer.deliveries.clear
      @email = Mailer.send_confirmation(@user)
    end

    it 'should send an email to a user' do
      expect(Mail::TestMailer.deliveries.length).to eq(1)
    end

    it 'should have the correct to email address' do
      expect(@email.to.length).to eq(1)
      expect(@email.to.first).to eq('hpottz@hogwarts.com')
    end

    it 'should have the correct from email address' do
      expect(@email.from.length).to eq(1)
      expect(@email.from.first).to eq('bikeblackspot@gmail.com')
    end

    it 'should have the correct subject' do
      expect(@email.subject).to eq('Welcome Harry Potter to Bike Black Spot!')
    end

    it 'should generate link with token to confirm' do
      @confirmation = Confirmation.find_by(user: @user.uuid)
      expect(@email.body).to include(@confirmation.token)
    end
  end

  describe 'send_report' do
    before(:each) do
      @user = User.create(name: 'Harry Potter', email: 'hpottz@hogwarts.com')
      Mail::TestMailer.deliveries.clear
      @category = Category.create(name: 'Danger Zone', description: 'There is danger in this zone.')
      @recipient = Recipient.create(name: 'Dumbledore', email: 'dumbledont@gmail.com', state: 'VIC')
      @location = Location.create(lat: '-37.8054312', long: '144.9714124')
      @report = Report.create(user: @user, category: @category, location: @location, description: @valid_description)
      @email = Mailer.send_report(@report)[0]
    end

    it 'should send an email to the recipient' do
      expect(Mail::TestMailer.deliveries.length).to eq(1)

    end
    it 'should have the correct from email address' do
      expect(@email.from.length).to eq(1)
      expect(@email.from.first).to eq('bikeblackspot@gmail.com')
    end
    it 'should have the correct to email address' do
      expect(@email.to.length).to eq(1)
      expect(@email.to.first).to eq(@recipient.email)
    end
    it 'should have the correct subject' do
      expect(@email.subject).to eq("Bike Black Spot Report for #{@location.formatted_address}")
    end
  end
end
