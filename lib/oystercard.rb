require_relative 'journey'

class Oystercard
  attr_reader :balance, :log, :in_journey
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 0
  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @balance = MINIMUM_BALANCE
    @log = []
    @journey = Journey.new
  end

  def add_money(amount)
    raise "The balance limit is #{BALANCE_LIMIT} pounds" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient Funds!' if insufficient_funds?
    start_journey(station)

  end

  def touch_out(station)
    end_journey(station)
  end

  def in_journey?
    @journey.status?
  end

  private
  def start_journey(station)
    @journey.start(station)
  end

  def end_journey(station)
    @journey.end(station)
    deduct(MINIMUM_FARE)
    log_journey
    @journey.reset
  end

  def log_journey
    @log << @journey.record
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
