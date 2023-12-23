require 'benchmark'

# Time Complexity: O(n^2)
# Space Complexity: O(1)

def water_area(heights)
  max_area = -Float::INFINITY

  heights.each_with_index do |height, i|
    left = i
    
    (left + 1...heights.length).each do |right|
      width = right - left
      height = [heights[left], heights[right]].min
      area = width * height
      max_area = [max_area, area].max
    end
  end

  max_area
end

# Time Complexity: O(n)
# Space Complexity: O(1)

def water_area_faster(heights)
  max_area = -Float::INFINITY
  left = 0
  right = heights.length - 1

  while left <= right
    width = right - left
    left_height = heights[left]
    right_height = heights[right]
    height = [left_height, right_height].min
    area = width * height
    max_area = [max_area, area].max

    if left_height < right_height
      left += 1
      next
    end
    if left_height > right_height
      right -= 1
      next
    end

    if left + 1 == right || right - 1 == left
      break
    end

    if left_height == right_height
      if heights[left + 1] >= heights[right - 1]
        left += 1
        next
      else
        right -= 1
        next
      end
    end
  end

  max_area
end

arrs = [
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3],
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 5,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 10,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 50,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 70,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 100,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 500,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 1000,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 1500,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 2000,
  [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3] * 5000,
]

output_file = File.new("benchmark_results.txt", "w")

puts "===================================================="
puts "Benchmarking water_area O(n^2) vs water_area_faster O(n)"
puts "NOTE: comparisson of results is the ratio between the two results water_area/water_area_faster"
puts "\n"
puts "github: @immprada"
puts "\n"
puts "\n"

arrs.each do |arr|
  puts "===================================================="
  puts "n: #{arr.length}"
  puts "O(n^2) vs O(n) in time complexity"
  puts "both are O(1) in space complexity"
  
  first_option = Benchmark.measure { water_area(arr) }.total
  second_option = Benchmark.measure { water_area_faster(arr) }.total
  result_comparisson = water_area(arr) / water_area_faster(arr)

  puts "O(n^2)"
  puts first_option
  puts "O(n)"
  puts second_option
  puts "----------------------------------------------------"
  puts "O(n^2) is #{(first_option / second_option).round(2)} O(n)"
  puts "comparisson of results #{result_comparisson}"

  output_file.puts "#{arr.length}, #{first_option}, #{second_option}, #{result_comparisson}"
end

puts "===================================================="

output_file.close
