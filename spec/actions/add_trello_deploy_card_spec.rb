require 'spec_helper'

RSpec.describe RandomIncidents::AddTrelloDeployCard do
  subject { described_class.new }

  describe '#add_new_deploy_card_to_board' do

    around do |spec|
      VCR.use_cassette('adding a deploy card to trello') { spec.run }
    end

    it 'saves a new deployment ticket to the board' do
      card = subject.add_new_deploy_card_to_board
      expect(card.name).to eq "Please Release PeopleFinder"
      expect(card.desc).
        to eq 'Use the ops manual to release the app into production.'
    end

    it 'chooses a random project to release' do
      stub_const('LIVE_APPS', described_class::LIVE_APPS.dup)
      allow(LIVE_APPS).to receive(:sample)

      subject.add_new_deploy_card_to_board
    end
  end

  describe '#call' do
    it 'is an alias for #add_new_deploy_card_to_board' do
      expect(subject.method(:call)).
        to eq subject.method(:add_new_deploy_card_to_board)
    end
  end

  describe '::LIVE_APPS' do
    specify { expect(described_class::LIVE_APPS).to eq ['PeopleFinder', 'Prison Visits'] }
  end
end
