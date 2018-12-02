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

def almost_equal(a, b)
  changes = 0
  a.length.times do |i|
    if a[i] != b[i]
      changes += 1
    end
  end
  (changes == 1) ? true : false
end

def same_letters(a, b)
  same_letters = ""
  a.length.times do |i|
    if a[i] == b[i]
      same_letters << a[i]
    end
  end
  same_letters
end

def common_letters input
  input_array = input.split("\n")
  i = 0
  j = 0
  n = input_array.length
  while (i < n)
    while (j < n)
      if (i != j && almost_equal(input_array[i], input_array[j]))
        return same_letters(input_array[i], input_array[j])
      end
      j += 1
    end
    j = 0
    i += 1
  end
end

puts "Part one solution: #{checksum input}"
puts "Part two solution: #{common_letters input}"