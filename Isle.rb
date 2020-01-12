require "./Bridge"

class Isle < Node
    def initialize(x, y, bridgeNb)
        super(x, y)
        @bridgeNb = bridgeNb
        @aff_string = "0/#{@bridgeNb}"
    end

    def to_s
        return "#{self.getBridgeNb()}/#{@bridgeNb}"
    end

    def linkStart(xDest, yDest)
        # Check invalid coord
        if (@x == xDest && @y == yDest) || (@x != xDest && @y != yDest)
            return false
        end
        
        side = getSide(xDest, yDest)
        
        if @linkNode[side] != nil
            return @linkNode[side].link(xDest, yDest)
        else
            return false
        end
    end

    def link(x, y)
        return (@x == x && @y == y)
    end

    def getBridgeNb
        return @linkNode.inject(0) do |nb, bridge|
            if bridge != nil && bridge.connected?(getSide(bridge.x, bridge.y))
                nb += bridge.getBridgeNb()
            end
            nb
        end
    end

    def fullConnected?
        return self.getBridgeNb() == @bridgeNb
    end
end