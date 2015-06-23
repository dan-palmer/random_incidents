require 'spec_helper'

RSpec.describe RandomIncidents::Supervisor do
  describe 'type' do
    it 'inherits from the celluloid supervision group class' do
      expect(described_class.new).to be_kind_of Celluloid::SupervisionGroup
    end
  end

  describe '.run!' do
    subject { described_class.run! }

    it 'registers the workers in the registry' do
      expect(subject.actors.size).to eq 2
      expect(subject[:sms_worker].action).to be_kind_of RandomIncidents::SendFakeIncidentSms
      expect(subject[:trello_worker].action).to be_kind_of RandomIncidents::AddTrelloDeployCard
    end
  end
end
