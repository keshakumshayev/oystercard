require 'oystercard.rb'

describe Oystercard do
  it { is_expected.to respond_to(:add_money).with(1).argument }
  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it { is_expected.to respond_to(:touch_out).with(1).argument }
  it { is_expected.to respond_to(:log) }

  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { double(:journey, entry_station: entry_station, exit_station: exit_station) }

  ADD_MONEY = 60
  TEST_DEDUCT_MONEY = 2

  context '#initalize' do
    it 'should check that the card has an empty list of journeys by default' do
      expect(subject.log).to be_empty
    end
  end

  context '#balance' do
    it 'has no money initially' do
      expect(subject.balance).to eq 0
    end

    it 'can be loaded with money' do
      expect { subject.add_money(ADD_MONEY) }.to change { subject.balance }.by ADD_MONEY
    end

    it "has a balance limit of #{Oystercard::BALANCE_LIMIT} Pounds" do
      subject.add_money(ADD_MONEY)
      expect { subject.add_money(ADD_MONEY) }.to raise_error "The balance limit is #{Oystercard::BALANCE_LIMIT} pounds"
    end
  end

  context '#touch in' do
    it 'can touch in when entering the tube' do
      allow(journey).to receive(:status?).and_return(true)
      allow(journey).to receive(:record).and_return({entry_station: entry_station, exit_station: exit_station})
      allow(journey).to receive(:reset).and_return(nil)
      allow(journey).to receive(:start).with(entry_station).and_return(entry_station)
      allow(journey).to receive(:end).with(entry_station).and_return(entry_station)

      subject = Oystercard.new(journey)
      subject.add_money(ADD_MONEY)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it 'cannot touch in with insufficient funds' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient Funds!'
    end
  end

  context '#touch out' do
    before do
      subject.add_money(ADD_MONEY)
      subject.touch_in(entry_station)
    end

    it 'can touch out when exiting the tube' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end

    it 'charges a standard fare when touching out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -Oystercard::MINIMUM_FARE
    end
  end

  context 'incorrect tapping' do
    it 'deduces a penalty fee for having not tapped in' do
      subject.add_money(ADD_MONEY)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -(Oystercard::MINIMUM_FARE+Oystercard::PENALTY_FARE)
    end

    it 'deduces a penalty fee for not tapping out' do
      subject.add_money(ADD_MONEY)
      subject.touch_in(entry_station)
      expect{ subject.touch_in(entry_station) }.to change{ subject.balance }.by -(Oystercard::MINIMUM_FARE+Oystercard::PENALTY_FARE)
    end
  end

  context 'stores information about travel' do
    before do
      subject.add_money(ADD_MONEY)
    end

    it 'should store a journey in the log when touched in and touched out' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.log[-1]).to eq ({entry_station: entry_station, exit_station: exit_station})
    end
  end
end
