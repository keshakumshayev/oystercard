require 'oystercard.rb'

describe Oystercard do
  it { is_expected.to respond_to(:add_money).with(1).argument }
  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it { is_expected.to respond_to(:touch_out).with(1).argument }
  it { is_expected.to respond_to(:log) }

  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { double(:journey, entry_station: entry_station, exit_station: exit_station)}

  ADD_MONEY = 60
  TEST_DEDUCT_MONEY = 2

  describe '#initalize' do
    it 'should check that the card has an empty list of journeys by default' do
      expect(subject.log).to be_empty
    end
  end

  describe '#balance' do
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

  describe '#touch in' do
    it 'can touch in when entering the tube' do
      subject.add_money(ADD_MONEY)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to be true
    end

    it 'gives the journey a station upon touching in' do
      subject.add_money(ADD_MONEY)
      expect(subject.touch_in(entry_station)).to eq(journey.entry_station)
    end

    it 'cannot touch in with insufficient funds' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient Funds!'
    end

    it 'deduces a penalty fee for not tapping out' do

    end
  end

  describe '#touch out' do
      before do
        subject.add_money(ADD_MONEY)
        subject.touch_in(entry_station)
      end

      it 'can touch out when exiting the tube' do

      end

      # it 'no longer in a journey after touching out' do
      #   subject.touch_out(exit_station)
      #   expect(subject.in_journey?).to be false
      # end

      it 'deduces a fare when tapping out' do
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it 'deduces a penalty fee for having not tapped in' do

      end

      #
      # it 'should store exit station' do
      #   subject.touch_out(exit_station)
      #   expect(subject.exit_station).to eq exit_station
      # end
    end

  describe 'stores information about travel' do
    before do
      subject.add_money(ADD_MONEY)
    end

    # it 'remembers the station it was last tapped at' do
    #   expect(subject.entry_station).to eq entry_station
    # end

    # it 'forgets entry station upon touching out' do
    #   expect { subject.touch_out(exit_s dtation) }.to change { subject.entry_station }.to be nil
    # end

    it 'should store a journey in the log when touched in and touched out' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)


      # subject.touch_in(entry_station)
      # subject.touch_in(entry_station)
      #
      # subject.touch_out(exit_station)
      # subject.touch_out(exit_station)

      expect(subject.log[-1]).to eq ({entry_station: entry_station, exit_station: exit_station})
    end
  end
end
