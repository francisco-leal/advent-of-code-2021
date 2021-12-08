input = File.readlines("input.txt").map(&:chomp)

def pretty_print(matrix)
  puts "----------------------------"
  matrix.each do |row|
    row.each do |cell|
      print "| #{cell} | "
    end
    print "\n"
  end
  puts "----------------------------"
end

draw_sequence = input[0].split(",").map(&:to_i)

boards = []
board = []
@results = []
input[1..input.length].each do |row|
  if row == ""
    unless board == []
      boards << board
      @results << [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
    end
    board = []
  else
    board << row.split(" ").map(&:to_i)
  end
end
boards << board
@results << [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]

def search_board(board, value)
  board.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if cell == value
        return [x, y]
      end
    end
  end
  [-1, -1]
end

def find_first_win(draw_sequence, boards)
  results = @results
  draw_sequence.each do |number|
    # puts "NUMBER: #{number}"
    boards.each_with_index do |board, index|
      x, y = search_board(board, number)
      if x != -1
        results[index][y][x] = 1

        if results[index][y].sum == 5
          return [index, number, results]
        end

        if results[index].map { |r| r[x] }.sum == 5
          return [index, number, results]
        end
      end
    end

    # results.each { |r| pretty_print(r) }
  end
end

def find_last_win(draw_sequence, boards)
  boards_with_solution = []
  results = @results
  draw_sequence.each do |number|
    # puts "NUMBER: #{number}"
    boards.each_with_index do |board, index|
      x, y = search_board(board, number)
      if x != -1
        results[index][y][x] = 1

        if results[index][y].sum == 5
          unless boards_with_solution.include? index
            boards_with_solution << index
          end
          if boards_with_solution.length == boards.length
            return [index, number, results]
          end
        end

        if results[index].map { |r| r[x] }.sum == 5
          unless boards_with_solution.include? index
            boards_with_solution << index
          end
          if boards_with_solution.length == boards.length
            return [index, number, results]
          end
        end
      end
    end

    # results.each { |r| pretty_print(r) }
  end
end

def calculate_score(index, boards, results)
  sum = 0
  results[index].each_with_index do |_, i|
    results[index][i].each_with_index do |cell, j|
      if cell == 0
        sum += boards[index][i][j]
      end
    end
  end
  sum
end

board_number, winning_number, results = find_first_win(draw_sequence, boards)

score = calculate_score(board_number, boards, results)

puts "[FIRST PART] SCORE: #{score}"
puts "[FIRST PART] TOTAL: #{score * winning_number}"

board_number, winning_number, results = find_last_win(draw_sequence, boards)

score = calculate_score(board_number, boards, results)

puts "[SECOND PART] SCORE: #{score}"
puts "[SECOND PART] TOTAL: #{score * winning_number}"
