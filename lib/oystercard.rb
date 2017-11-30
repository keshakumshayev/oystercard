require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :log
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 0
  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @log = []
  end

  def add_money(amount)
    raise "The balance limit is #{BALANCE_LIMIT} pounds" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    @journey = Journey.new
    # charge fee if entry station is nil
    # AND exit station is not (or vice versa)
    # @journey.end
    # @log << @journey.record
    # @journey.reset
    raise 'Insufficient Funds!' if insufficient_funds?
    @journey.start(station)
end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    #@log << { @entry_station => @exit_station }
    #if BOTH entry and exit station written to the log are not nil reset values
  end

  def in_journey?
    !@journey.entry_station.nil?
  end

  private

  def log_journey
    # @journey.end
    @log << @journey.record
    # @journey.reset
  end

  def deduct(amount)
    @balance -= amount
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end
end
