require 'journey'

describe Journey do

  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  it { is_expected.to respond_to(:start).with(1).argument }
  it { is_expected.to respond_to(:end).with(1).argument }
  it { is_expected.to respond_to(:entry_station) }
  it { is_expected.to respond_to(:exit_station) }
  it { is_expected.to respond_to(:record) }

  it 'remembers the station where the journey started' do
    expect{ subject.start(entry_station) }.to change{ subject.entry_station }.to eq entry_station
  end

  it 'remembers the station where the journey ends' do
    expect { subject.end(exit_station) }.to change { subject.exit_station }.to eq exit_station
  end

  it 'records the journey in a hash' do
    subject.start(entry_station)
    subject.end(exit_station)
    expect(subject.record).to eq({:entry_station => entry_station, :exit_station => exit_station})
  end
end
