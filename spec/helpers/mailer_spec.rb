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
      expect(@email.from.first).to eq('confirmation-test@test.com')
    end

    it 'should have the correct subject' do
      expect(@email.subject).to eq('Welcome Harry Potter to Bike Blackspot!')
    end

    it 'should generate link with token to confirm' do
      @confirmation = Confirmation.find_by(user: @user.uuid)
      expect(@email.body).to include(@confirmation.token)
    end
  end

  describe 'send_reports' do
    email = {}
    report = {}
    location = {}
    before(:each) do
      user = User.create(name: 'Harry Potter', email: 'hpottz@hogwarts.com')
      Mail::TestMailer.deliveries.clear
      category = Category.create(name: 'Danger Zone', description: 'There is danger in this zone.')
      recipient = Recipient.create(name: 'Dumbledore', email: 'dumbledont@gmail.com', state: 'VIC')
      location = Location.create(lat: '-37.8054312', long: '144.9714124')
      report = Report.create(user: user, category: category, location: location, description: 'Description')

    end
    describe 'send_state_report' do
      before(:each) do
        email = Mailer.send_state_report(report)[0]
      end

      it 'should send an email to the recipient' do
        expect(Mail::TestMailer.deliveries.length).to eq(1)

      end
      it 'should have the correct from email address' do
        expect(email.from.length).to eq(1)
        expect(email.from.first).to include('@bikeblackspot.org')
      end
      it 'should have the correct to email address' do
        expect(email.to.length).to eq(1)
        expect(email.to.first).to eq('dumbledont@gmail.com')
      end
      it 'should have the correct subject' do
        expect(email.subject).to eq('Bike Blackspot Report for 11 Nicholson Street, Carlton VIC 3053, Australia')
      end
      it 'should set sent_at time on report' do
        expect(report.sent_at).to_not be_nil
      end
    end
    describe 'send_user_report' do
      before(:each) do
        email = Mailer.send_user_report(report)
      end

      it 'should send an email to the recipient' do
        expect(Mail::TestMailer.deliveries.length).to eq(1)

      end
      it 'should have the correct from email address' do
        expect(email.from.length).to eq(1)
        expect(email.from.first).to include('@bikeblackspot.org')
      end
      it 'should have the correct to email address' do
        expect(email.to.length).to eq(1)
        expect(email.to.first).to eq('hpottz@hogwarts.com')
      end
      it 'should have the correct subject' do
        expect(email.subject).to eq('Bike Blackspot Report for 11 Nicholson Street, Carlton VIC 3053, Australia')
      end
    end
  end
end
