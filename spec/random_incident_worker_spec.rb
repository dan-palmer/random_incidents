require 'spec_helper'

class ExampleAction
  def call
    # where the magic happens
  end
end

RSpec.describe RandomIncidents::RandomIncidentWorker do
  let(:example_action) { ExampleAction.new }

  subject { described_class.new example_action }

  before { allow(Kernel).to receive(:sleep) }

  describe 'initialize' do
    it 'configures the actor' do
      expect(subject.action).to eq example_action
    end
  end

  describe '#run_async' do
    it 'allows the actor to run the perform method continuosly in the background' do
      expect(subject).to receive(:async).and_return(subject)
      expect(subject).to receive(:run)

      subject.run_async
    end
  end

  describe '#perform' do
    it 'calls the action' do
      expect(example_action).to receive(:call)
      subject.perform
    end

    it 'updates the delay' do
      expect { subject.perform }.to change { subject.seconds_delay }
    end
  end

  describe '#run' do
    it 'calls perform in a loop' do
      allow(subject).to receive(:perform).at_least(:twice)
      Thread.new { subject.run }.kill
    end
  end

  describe 'type' do
    it { is_expected.to be_a Celluloid }
  end
end
