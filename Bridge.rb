require "./Node"

class Bridge < Node
    def initialize(x, y)
        super(x, y)

        # -1 -> no bridge
        #  0 -> vertical bridge
        #  1 -> horizontal bridge
        @direction = -1
        @bridgeNb = 0
    end

    def to_s
        if @direction == -1
            return "   "
        elsif @direction == 0
            if @bridgeNb == 2
                return "| |"
            else
                return " | "
            end
        else
            if @bridgeNb == 2
                return "==="
            else
                return "---"
            end
        end
    end

    def link(x, y)
        # Check
        if (@x == x && @y == y)
            return false
        end
        
        side = getSide(x, y)
        
        # Check if we not cut an existing bridge
        if @direction != -1
            if @direction != getDirection(side)
                return false
            end
        end

        if @linkNode[side] != nil && @linkNode[side].link(x, y) == true
            if @direction == -1
                @direction = getDirection(side)
                @bridgeNb = 1
            else
                @bridgeNb += 1
                if @bridgeNb > 2
                    @bridgeNb = 0
                    @direction = -1
                end
            end
        else
            return false
        end
        return true
    end

    def getBridgeNb
        return @bridgeNb
    end

    # Return true if the isle is connected to the bridge
    def connected?(side)
        return getDirection(side) == @direction
    end

    private
    def getDirection(side)
        if (side == 0 || side == 2)
            return 1
        else
            return 0
        end
    end
end