#!/usr/bin/env ruby
x, y, z = [0, 0, 0]

result = File.readlines("input.txt")
  .map(&:chomp)
  .map(&:split)
  .each do |line|
    puts line
    if line[0] == "forward"
      x += line[1].to_i
      z += line[1].to_i * y
    elsif line[0] == "down"
      y += line[1].to_i
    elsif line[0] == "up"
      y -= line[1].to_i
    end
  end

puts "PART ONE: #{x * y}"
puts "PART TWO: #{x * z}"
