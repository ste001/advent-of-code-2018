def find_sum input
  sum = 0
  input.each_line do |number|
    sum += number.to_i
  end
  return sum
end

def find_double_frequency input
  frequences = {}
  found = false
  current_freq = 0
  while (not found)
    input.each_line do |number|
      current_freq += number.to_i
      if (frequences.has_key?(current_freq))
        found = true
        return current_freq
      else
        frequences[current_freq] = 1
      end
    end
  end
end

input = File.read("input.txt")
puts "Part one answer: #{find_sum(input)}"
puts "Part two answer: #{find_double_frequency(input)}"