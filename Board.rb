require 'pry-byebug'
#Create a board class
#Create an Os class. this will inherit from board class
#Create an Xs class. this will inherit from board class
class Board
  def initialize()
    @@board = [['_','_','_'], ['_','_','_'], ['_','_','_']]
  end

  def self.printBoard()
    @@board.each do |element|
      element.each {|element| print element + ' '}
      puts ''
    end
  end

  #player variable is string of 'X' or 'O'
  def self.updateBoard(row, column, player)
    @@board[row][column] = player
  end

  def self.returnBoard()
    return @@board
  end

end


