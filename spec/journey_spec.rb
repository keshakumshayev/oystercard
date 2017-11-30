require 'journey'

describe Journey do

  it { is_expected.to respond_to(:start).with(1).argument }
  it { is_expected.to respond_to(:end).with(1).argument }
  it { is_expected.to respond_to(:entry_station) }
  it { is_expected.to respond_to(:exit_station) }
  it { is_expected.to respond_to(:record) }

end
