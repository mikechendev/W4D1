require_relative 'tic_tac_toe'
require_relative 'polytreenode'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    if self.next_mover_mark == :X
      TicTacToeNode.new(board, :O, prev_move_pos)
    else
      TicTacToeNode.new(board, :X, prev_move_pos)
    end
  end
end
