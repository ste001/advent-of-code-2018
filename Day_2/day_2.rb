input = File.read("input.txt")

def checksum input
  checksum = 0
  twice_sum = 0
  thrice_sum = 0

  input.each_line do |id|
    letters = {}
    id.each_char do |char|
      if (letters.has_key?(char))
        letters[char] += 1
      else
        letters[char] = 1
      end
    end
    if (letters.has_value?(2))
      twice_sum += 1
    end
    if (letters.has_value?(3))
      thrice_sum += 1
    end
  end
  checksum = twice_sum * thrice_sum
  checksum
end

puts "Part one solution: #{checksum input}"