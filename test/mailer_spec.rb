require_relative 'spec_helper'
require_relative '../helpers/mailer'

describe 'Mailer' do
  include Mail::Matchers

  Mail.defaults do
    delivery_method :test
  end

  describe 'send_confirmation' do

    before(:each) do
      Mail::TestMailer.deliveries.clear
      @user = User.create(name: 'Harry Potter', email: 'hpottz@hogwarts.com')
      @email = Mailer.send_confirmation(@user)
    end

    it 'should send an email to a user' do
      expect(Mail::TestMailer.deliveries.length).to eq(1)
    end

    it 'should have the correct to email address' do
      expect(@email.from.length).to eq(1)
      expect(@email.to.first).to eq('hpottz@hogwarts.com')
    end

    it 'should have the correct from email address' do
      expect(@email.from.length).to eq(1)
      expect(@email.from.first).to eq('somebody@greens.com')
    end

    it 'should have the correct subject' do
      expect(@email.subject).to eq('Welcome Harry Potter to Bike Black Spot!')
    end

    it 'should generate link with token to confirm' do
      @confirmation = Confirmation.find_by(user: @user.uuid)
      expect(@email.body).to include(@confirmation.token)
    end
  end
end
