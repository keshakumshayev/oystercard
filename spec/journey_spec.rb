require 'journey'

describe Journey do
  it { is_expected.to respond_to(:start) }
  it { is_expected.to respond_to(:end) }
end
