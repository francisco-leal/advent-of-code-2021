#!/usr/bin/env ruby

prev_value = Float::INFINITY

total = File.open("./input.txt")
  .readlines
  .map(&:chomp)
  .map(&:to_i)
  .inject(0) { |total, value| total += 1 if value > prev_value; prev_value = value; total; }

puts total
