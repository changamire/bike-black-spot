require 'rspec'

describe 'param_validation' do
  params = {name: 'testName', email: 'testEmail@email.com'}

  required = %w(name email)
  permitted = %w(name email postcode)
  describe 'params_permitted' do
    it 'Should not allow when permitted param empty' do
      params = {name: '', email: 'testEmail@email.com'}
      expect(params_permitted?(params,permitted)).to be_falsey
    end
    it 'Should not allow when non permitted param given' do
      params = {name: 'sadsad', email: 'testEmail@email.com', derp: 'test'}
      expect(params_permitted?(params,permitted)).to be_falsey
    end
    it 'Should not allow when only non permitted param given' do
      params = { derp: 'testEmail@email.com'}
      expect(params_permitted?(params,permitted)).to be_falsey
    end
    it 'Should allow when permitted params given' do
      params = {name: 'aaaa', email: 'testEmail@email.com'}
      expect(params_permitted?(params,permitted)).to be_truthy
    end
  end

  describe 'params_required' do


    it 'Should not allow when required param missing' do
      params = {name: 'testName'}
      expect(params_required?(params,required)).to be_falsey
    end
    it 'Should not allow when required param missing' do
      params = {email: 'testEmail@email.com'}
      expect(params_required?(params,required)).to be_falsey
    end
    it 'Should allow when no missing params' do
      params = {name: 'testName', email: 'testEmail@email.com'}
      expect(params_required?(params,required)).to be_truthy
    end
  end
end