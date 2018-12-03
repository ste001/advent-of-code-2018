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
    column = claim_array[2].strip.to_i
    row = claim_array[3].strip.to_i
    width = claim_array[4].strip.to_i
    height = claim_array[5].strip.to_i
    height.times do |i|
      width.times do |j|
        if fabric[column + j][row + i] == '1'
          fabric[column + j][row + i] = 'X'
        elsif fabric[column + j][row + i] == '.'
          fabric[column + j][row + i] = '1'
        end
      end
    end
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
puts overlaps_count fabric