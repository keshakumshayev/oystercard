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
    @in_journey = false
  end

  def add_money(amount)
    raise "The balance limit is #{BALANCE_LIMIT} pounds" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient Funds!' if insufficient_funds?
    @journey.start(station)
    @in_journey = true
    if false
      if @journey.entry_station == nil and @journey.exit_station == nil
        @journey.start(station)
      elsif @journey.entry_station != nil and @journey.exit_station == nil
        log_journey
        deduct(MINIMUM_FARE+PENALTY_FARE)
        @journey.start(nil)
        @journey.end(nil)
        @journey.start(station)
      end
    end
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey.end(station)
    @in_journey = false
    if false
      if !@journey.exit_station.nil?
        deduct(PENALTY_FARE)
      end
    end
  end

  # def in_journey?
  #   @in_journey =
  # end

  private

  # def end_journey
  #   log_journey
  #   @in_journey = false
  # end

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
