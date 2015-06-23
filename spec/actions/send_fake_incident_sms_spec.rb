require 'spec_helper'

RSpec.describe RandomIncidents::SendFakeIncidentSms do
  subject { described_class.new }

  describe '#send_sms' do
    it 'sends a fake incident sms to somebody' do
      VCR.use_cassette('twilio sms') do
        response = subject.send_sms

        expect(response.status).to eq 'queued'
        expect(response.body).to eq "It's time to break some stuff"
      end
    end
  end

  describe '#call' do
    it 'is an alias for #send_sms' do
      expect(subject.method(:call)).to eq subject.method(:send_sms)
    end
  end
end
