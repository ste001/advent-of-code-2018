input = File.read('input.txt')
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

puts input_array.length