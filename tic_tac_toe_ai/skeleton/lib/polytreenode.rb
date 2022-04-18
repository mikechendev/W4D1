class PolyTreeNode
attr_reader :value, :parent
attr_accessor :children
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(arg)
        old_parent = self.parent
        if old_parent != nil
            @parent.children.delete(self)            
        end
        if arg == nil
            @parent = nil
        else
            @parent = arg
            @parent.children << self
        end
    end

    def add_child(child)
        if !@children.include?(child)
            child.parent = self
        end
    end

    def remove_child(child)
        if @children.include?(child)
            child.parent = nil
        else
            raise "Not a Child."
        end
    end

    def dfs(target)
        return self if self.value == target

        self.children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result == nil
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty?
            el = queue.shift
            return el if el.value == target
            el.children.each { |child| queue << child }
        end
        nil
    end
end