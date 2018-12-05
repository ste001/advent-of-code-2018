def polymer_collapse input
  input_array = input.split('')
  i = 1
  while (i < input_array.length - 1)
    if (input_array[i].match?(/[[:lower:]]/) \
      && input_array[i+1] == input_array[i].upcase \
      || input_array[i].match?(/[[:upper:]]/) \
      && input_array[i+1] == input_array[i].downcase)
      input_array.delete_at(i)
      input_array.delete_at(i)
    elsif (input_array[i].match?(/[[:lower:]]/) \
      && input_array[i-1] == input_array[i].upcase \
      || input_array[i].match?(/[[:upper:]]/) \
      && input_array[i-1] == input_array[i].downcase)
      input_array.delete_at(i-1)
      input_array.delete_at(i-1)
      i -= 1
    else
      i += 1
    end
  end
  input_array.length
end

def remove_units input, unit
  input_array = input.split('')
  input_array.each do |char|
    input_array.delete(unit) if char == unit
    input_array.delete(unit.upcase) if char == unit.upcase
  end
  input_array.join("")
end

def find_smallest_polymer input
  smallest = input.length
  letter = 'a'
  26.times do |index|
    new_input = remove_units input, letter
    length = polymer_collapse new_input
    smallest = length if length < smallest
    letter = (letter.ord + 1).chr
  end
  smallest
end

input = File.read('input.txt')
puts "Part one solution: #{polymer_collapse input}"
puts "Part two solution: #{find_smallest_polymer input}"