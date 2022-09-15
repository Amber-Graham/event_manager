require 'csv'
require 'erb'

puts 'Attendee Report initialized'

def execute_csv
  contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
  )
end

def save_email(form_email)
  filename = "output/attendee_report.html"

  File.open(filename, 'w') do |file|
    file.puts form_email
  end
end

def reghour
  contents = execute_csv
  times = []
  contents.each do |row|
    regdate = row[:regdate]
    time = DateTime.strptime(regdate, '%D %R').strftime('%I %p')
    times << time
  end
  freq = times.inject(Hash.new(0)) { |_k,v| _k[v] += 1; _k}
  sorted_freq = freq.sort_by { |_k, v| v}.reverse.to_h
  top_times = sorted_freq.keys[0..2]
  top_times.map { |k,v| "#{k}"}.flatten.join(', ')
end

def regday
  contents = execute_csv
  days = []
  contents.each do |row|
    regdate = row[:regdate]
    day = DateTime.strptime(regdate, '%D %R').strftime('%A')
    days << day
  end
  freq = days.inject(Hash.new(0)) { |k,v| k[v] += 1; k}
  sorted_freq = freq.sort_by { |k, v| v}.reverse.to_h
  top_days = sorted_freq.keys[0..2]
  top_days.map { |k,v| "#{k}"}.flatten.join(', ')
end

conference_email = File.read('event_report.erb')
erb_template = ERB.new conference_email

form_email = erb_template.result(binding)
save_email(form_email)