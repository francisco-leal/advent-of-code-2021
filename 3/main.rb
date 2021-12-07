#!/usr/bin/env ruby
lines = File.readlines("input.txt")

result = lines.map(&:chomp)
  .map { |l| l.split("") }
  .map { |l| l.map(&:to_i) }
  .reduce(&:zip)
  .map(&:flatten)
  .map(&:sum)

gamma = result.map { |x| x > lines.length / 2 ? 1 : 0 }.join("")

puts "GAMMA: #{gamma}"

epsilon = gamma.split("").map { |c| c == "1" ? "0" : "1" }.join("")

puts "EPSILON: #{epsilon}"

puts "PART ONE: #{gamma.to_i(2) * epsilon.to_i(2)}"

matrix = lines.map(&:chomp)
  .map { |l| l.split("") }
  .map { |l| l.map(&:to_i) }

oxygen = matrix
index = 0
while oxygen.length > 1
  temp = oxygen
  sums = temp.reduce(&:zip).map(&:flatten).map(&:sum)
  oxygen = oxygen.select { |m| m[index] == (sums[index].to_f >= oxygen.length / 2.0 ? 1 : 0) }
  index += 1
end

co2 = matrix
index = 0
while co2.length > 1
  temp = co2
  sums = temp.reduce(&:zip).map(&:flatten).map(&:sum)
  co2 = co2.select { |m| m[index] == (sums[index].to_f < co2.length / 2.0 ? 1 : 0) }
  index += 1
end

oxygen = oxygen.flatten.join("")
co2 = co2.flatten.join("")

puts "OXYGEN: #{oxygen}"
puts "CO2: #{co2}"

puts "PART TWO: #{oxygen.to_i(2) * co2.to_i(2)}"
