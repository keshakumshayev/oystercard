require './lib/oystercard'
require './lib/journey'

# # OYSTERCARD
# # parts 4-5
# # # new oyster card
# p oyster = Oystercard.new
# # # should display a balance of 0
# # p oyster.balance
# # # add some money
# # p oyster.add_money(5)
# # # balance should now return 5
# # p oyster.balance
# # part 6
# # p 'expect an error message when adding 91'
# # p 'pounds to the oyster card because the limit is 90'
# # p oyster.add_money(91)
# # part 7
# # p oyster.add_money(50)
# # p 'expected balance 50'
# # p oyster.balance
# # p 'expecting to subtract £2'
# # p oyster.deduct(2)
# # part 8
# # p oyster.touch_in
# # p 'expect true'
# # p oyster.in_journey?
# # p oyster.touch_out
# # p 'expect false'
# # p oyster.in_journey?
# # part 9
# # p 'no money, should be unable to touch in'
# # p 'FAIL' if oyster.touch_in
# # part 10
# p oyster.add_money(10)
# # p oyster.touch_in
# # p oyster.touch_out
# # p 'FAIL' if oyster.balance != 10-Oystercard::MINIMUM_FARE
# # part 11
# # p oyster.touch_in('shoreditch')
# # p 'FAIL' if oyster.entry_station != 'shoreditch'
# #part 12
# # p oyster.touch_in("shoreditch")
# # p oyster.touch_out("picadilly")
# # p "FAIL" if oyster.log.empty?
# # p "should return an empty log of journeys"
# # p 'FAIL' if !oyster.log.empty?
# # p "should store one journey in a hash"
# # p oyster.log
# # p oyster.touch_in("shoreditch")
# # p oyster.touch_out("picadilly")
# # p oyster.log
# # p 'FAIL' if oyster.log[-1] != {entry_station: "shoreditch", exit_station: "picadilly"}
# # part 13
# p 'expect to fail'
# p station = Station.new
p journey = Journey.new
p journey.start('aldgate east')
p journey.end('hoxton')
p 'FAIL' if journey.entry_station != 'aldgate east'
p journey.record
