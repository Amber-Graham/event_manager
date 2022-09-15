require 'csv'
require 'strftime'
require 'date'
require 'pry-byebug'

require 'time'
puts 'Attendee Report initialized'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def reghour(regdate)
  times = [] << DateTime.strptime(regdate, '%D %R').strftime('%H')
end

contents.map do |row|
  regdate = reghour(row[:regdate])
  puts regdate
end