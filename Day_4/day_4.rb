require 'date'

input = File.read("input.txt")
Shift = Struct.new(:time, :guard_id, :status)

def ordered_shifts input
  shifts = []
  input.each_line do |record|
    record_arr = record.split(/[\[\]]/)
    date =  DateTime.strptime(record_arr[1], '%Y-%m-%d %H:%M')
    rec = Shift.new(date, record_arr[2].scan(/\d+/).join, \
    record_arr[2].scan(/[a-z]+\s[a-z]+/).join)
    shifts << rec
  end
  shifts.sort {|x,y| x.time <=> y.time}
end

def create_hash shifts
  guards = {}
  curr_id = 0
  start_sleep = 0
  shifts.each do |shift|
    if shift.status == "falls asleep"
        start_sleep = shift.time.minute
    elsif shift.status == "wakes up"
        guards[curr_id][:sleep_minutes] += shift.time.minute - start_sleep
        guards[curr_id][:sleep_intervals] << "#{start_sleep}-#{shift.time.minute - 1}\n"
        start_sleep = 0
    elsif guards.has_key?(shift.guard_id)
      curr_id = shift.guard_id
    else
      guards[shift.guard_id] = {:sleep_minutes => 0, :sleep_intervals => ""}
      curr_id = shift.guard_id
    end
  end
  guards
end

def find_sleepiest_guard guards
  max_mins = 0
  id = 0
  guards.each_key do |key|
    if (guards[key][:sleep_minutes] > max_mins)
      max_mins = guards[key][:sleep_minutes]
      id = key
    end
  end
  id
end

def find_best_minute guards, id
  intervals = guards[id][:sleep_intervals]
  minutes = []
  60.times {|n| minutes[n] = 0}
  intervals.each_line do |line|
    intervals_array = line.split('-')
    i = intervals_array[0].to_i
    j = intervals_array[1].to_i
    (i..j).each {|n| minutes[n] += 1}
  end
  freq = 0
  max_min = 0
  minutes.each_index do |index|
    if minutes[index] > freq
      freq = minutes[index]
      max_min = index
    end
  end
  [max_min, freq]
end

shifts = ordered_shifts input
guards = create_hash shifts
id = find_sleepiest_guard guards
max_min = find_best_minute(guards, id)[0]

puts "Part one solution: #{max_min.to_i * id.to_i}"

chosen_guard = 0
minute = 0
times = 0
guards.each_key do |key|
  best_minute = find_best_minute(guards, key)
  if (best_minute[1] > times)
    chosen_guard = key
    minute = best_minute[0]
    times = best_minute[1]
  end
end

puts "Part two solution: #{chosen_guard.to_i * minute.to_i}"