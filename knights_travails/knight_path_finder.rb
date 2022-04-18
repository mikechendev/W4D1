require_relative 'polytreenode'

class KnightPathFinder
    attr_reader :set, :pos
    attr_accessor :root_node
    BOARD = Array.new(8) {Array.new(8)}

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @pos = pos
        @considered_positions = [pos]
        build_move_tree
    end

    def self.valid_moves(pos)
        current_x, current_y = pos[0], pos[1]
        arr = []
        moves = [[2,1],[1,2],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
        moves.each do |move|
            arr << [move[0] + current_x, move[1] + current_y]
        end
        arr.reject! { |pos| pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0 }
        arr
    end

    def new_move_positions(pos)
        remaining_pos = KnightPathFinder.valid_moves(pos).reject { |move| @considered_positions.include?(move) }
        @considered_positions += remaining_pos
        remaining_pos
    end

    def build_move_tree
        queue = [root_node]

        until queue.empty?
            el = queue.shift
            val = el.value #val is a position
            new_move_positions(val).each do |pos|
                new_node = PolyTreeNode.new(pos)
                el.add_child(new_node)
                queue << new_node
            end
        end
        root_node
    end

    def find_path(target)
        node = root_node.dfs(target)
        res = trace_path_back(node).reverse.map do |node|
            node.value
        end
        res
    end

    def trace_path_back(end_node)
        queue = []
        current_node = end_node
        until current_node.nil?
            queue << current_node
            current_node = current_node.parent 
        end
        queue
    end
end

p kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]