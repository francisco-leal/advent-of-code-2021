#!/usr/bin/env ruby

parsed_input = File.open("./input.txt").readlines.map(&:to_i)

total = parsed_input[0...-3].zip(parsed_input[3..-1]).count { |x, y| x < y }

puts total
