require_relative 'Board'
require 'pry-byebug'

module Input
  def prompt(player)
    if player == 'X'
      puts "Player 1. Pick your position: Position is defined as 'row, column'. Example is '0, 2'."
      position = gets.chomp
    elsif player == 'O'
      puts "Player 2. Pick your position: Position is defined as 'row, column'. Example is '0, 2'."
      position = gets.chomp
    end
    position = position_to_integer(position)
    row = position[0]
    column = position[1]
    if(!check_position_in_bounds(row, column))
      prompt(player)
    else
      return position
    end
  end

  def position_to_integer(position)
    position = position.split(',')
    position[0] = position[0].to_i
    position[1] = position[1].to_i
    return position
  end

  def check_position_in_bounds(row, column)
    range = 0..2
    if range.include?(row) && range.include?(column)
      return true
    else
      puts 'Pick a valid spot! Row/Column cannot be greater than 2 nor less than 0.'
      return false
    end
  end
end

class PlayGame < Board
include Input
  def initialize()
    super
    play()
  end

  def play()
    board = Board.new()
    puts "Welcome to Tic-Tac-Toe. To win, you must mark 3 places in a row!"
    continue_game = true
    current_player = 'X'
    while(continue_game)
      position = prompt(current_player)
      Board.updateBoard(position[0], position[1], current_player)
      Board.printBoard
      if current_player == 'X'
        current_player = 'O'
      elsif current_player == 'O'
        current_player = 'X'
      end
      result = continue_game?(Board.returnBoard)
      if(result == 'X')
        puts 'Player 1 has won!'
        break
      elsif(result == 'O')
        puts 'Player 2 has won!'
        break
      end
    end
  end

  def continue_game?(board)
    down_slash_row = [board[0][0], board[1][1], board[2][2]]
    up_slash_row = [board[2][0], board[1][1], board[0][2]]
    left_column = [board[0][0], board[1][0], board[2][0]]
    middle_column = [board[0][1], board[1][1], board[2][1]]
    right_column = [board[0][2], board[1][2], board[2][2]]
    first_row = [board[0][0], board[0][1], board[0][2]]
    second_row = [board[1][0], board[1][1], board[1][2]]
    third_row = [board[2][0], board[2][1], board[2][2]]

    winning_rows = [first_row, second_row, third_row, down_slash_row, up_slash_row, left_column, middle_column, right_column]
    winning_rows.each do |element|
      if(element.all? { |element| element == 'X'})
        return 'X'
      end
      if(element.all? { |element| element == 'O'})
        return 'O'
      end
    end
    return false
  end

end

first = PlayGame.new()

#Board.showBoard