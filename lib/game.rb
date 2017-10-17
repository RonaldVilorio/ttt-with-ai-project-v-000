require 'pry'
class Game
  include Players
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row

    [0,3,6], #left horizontal column
    [1,4,7], #Middle horizontal column
    [2,5,8], #Right horizontal column

    [0,4,8], #left to bottom right diagonal
    [2,4,6] #right to bottom left diagonal
  ]
  attr_accessor :board,:player_1,:player_2

  def initialize(player_1 = Human.new("X") || Computer.new("X"), player_2 = Human.new("O") || player_2 = Computer.new("O"),board = Board.new)
    @player_1 = player_1 if player_1
    @player_2 = player_2 if player_2
    @board = board if board
  end

  def current_player
     if board.turn_count.even?
       player_1
     else
       player_2
     end
  end

  def over?
    draw? || won?
  end
  def won?
    WIN_COMBINATIONS.detect{|combination|
      board.cells[combination[0]] == "X" && board.cells[combination[1]] == "X" && board.cells[combination[2]] == "X" ||
      board.cells[combination[0]] == "O" && board.cells[combination[1]] == "O" && board.cells[combination[2]] == "O"

    }
    # key: WIN_COMBINATIONS: array of arrays
    # combination: a winning combination ex: [0,1,2]
    # combination[0]: ex:0

    # goes through the winning combinations
    # checks each board cell index by placing in the index of the combination and comparing that to "X" or "O"
    # On the first loop will check the index 0,1,2 of board.cells and then on the next iteration check the next combination
    # until a match is found

  end
  def draw?
    board.full? && won? == nil
  end
  def winner
    if won?
      board.cells[won?[0]]
      board.cells[won?[1]]
      board.cells[won?[2]]
    else
      nil
   end

  end

  def turn

    move = current_player.move(board)

    if board.valid_move?(move)
      board.update(move,current_player)
      board.display
    else
      turn
    end

    # binding.pry
  end

  def play
    until over?
      turn
    end

      if draw?
        puts "Cat's Game!"
      else
        puts "Congratulations #{winner}!"
      end
      # binding.pry

  end

end
