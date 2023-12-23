require_relative './ds/heap'

def data = Struct.new(:value, :frequency)

def organize_letters(string)
  letters = Hash.new(0)
  queue = Heap.new
  string_size = string.size
  new_string = ""
  
  string.each_char { |char| letters[char] += 1 }

  letters.each do |letter, frequency|
    queue.insert_smallest_to_highest(data.new(letter, frequency))
  end


  while queue.size > 0
    first_biggest = queue.pop
    second_biggest = queue.pop

    new_string += first_biggest.value
    queue.insert_smallest_to_highest(data.new(first_biggest.value, first_biggest.frequency - 1)) if first_biggest.frequency > 1

    break if second_biggest.nil?
    
    new_string += second_biggest.value
    queue.insert_smallest_to_highest(data.new(first_biggest.value, second_biggest.frequency - 1)) if second_biggest.frequency > 1
  end

  queue.size > 0 ? '' : new_string
end


puts "#{organize_letters('aacab') == 'acaba'}"
puts "#{organize_letters('aaacab') == ''}"