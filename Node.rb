# frozen_string_literal: true

class Node
    attr_reader :x, :y

    def initialize(x, y)
        @x = x
        @y = y

        # link node : left - top - right - bottom
        @linkNode = Array.new(4)

        # Display character
        @aff_string = "   "
    end

    def setLinkNode(left, top, right, bottom)
        @linkNode[0] = left
        @linkNode[1] = top
        @linkNode[2] = right
        @linkNode[3] = bottom
    end

    def to_s
        return @aff_string.to_s
    end

    def link(x, y)

    end

    private
    def getSide(x, y)
        if x < @x
            return 0
        elsif x > @x
            return 2
        elsif y < @y
            return 3
        elsif y > @y
            return 1
        end
    end
end
