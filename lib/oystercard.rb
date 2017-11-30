class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :log
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 0
  MINIMUM_FARE = 2

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @log = []
  end

  def add_money(amount)
    raise "The balance limit is #{BALANCE_LIMIT} pounds" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station = nil)
    # charge fee if entry station is nil
    # AND exit station is not (or vice versa)
    raise 'Insufficient Funds!' if insufficient_funds?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @log << { @entry_station => @exit_station }
    #if BOTH entry and exit station written to the log are not nil reset values
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

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
