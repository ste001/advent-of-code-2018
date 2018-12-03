$inches = 1000

def create_fabric size
  fabric = Array.new(size) { Array.new(size)}
  size.times do |i|
    size.times do |j|
      fabric[i][j] = '.'
    end
  end
  fabric
end

def populate_fabric input, fabric
  input.each_line do |claim|
    claim_array = claim.split(/[#@:,x]/)
    id = claim_array[1].strip
    column = claim_array[2].strip.to_i
    row = claim_array[3].strip.to_i
    width = claim_array[4].strip.to_i
    height = claim_array[5].strip.to_i
    height.times do |i|
      width.times do |j|
        if fabric[column + j][row + i] == '.'
          fabric[column + j][row + i] = id
        else
          fabric[column + j][row + i] = 'X'
        end
      end
    end
  end
end

def intact_claim input, fabric
  input.each_line do |claim|
    intact = true
    claim_array = claim.split(/[#@:,x]/)
    id = claim_array[1].strip
    column = claim_array[2].strip.to_i
    row = claim_array[3].strip.to_i
    width = claim_array[4].strip.to_i
    height = claim_array[5].strip.to_i
    height.times do |i|
      width.times do |j|
        if fabric[column + j][row + i] != id
          intact = false
        end
      end
    end
    return id if intact
  end
end

def overlaps_count fabric
  count = 0
  $inches.times do |i|
    $inches.times do |j|
      if fabric[i][j] == 'X'
        count += 1
      end
    end
  end
  count
end

fabric = create_fabric $inches
input = File.read('input.txt')
populate_fabric input, fabric
puts "Part one solution: #{overlaps_count fabric}"
true_claim = intact_claim(input, fabric)
puts "Part two solution: #{true_claim}"