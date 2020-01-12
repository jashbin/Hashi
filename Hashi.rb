require "./Isle"
require "./Bridge"

class Hashi
    def initialize(mapFile)
        map = File.open(mapFile)
        mapData = map.readlines.map(&:chomp)

        @grid = nil
        mapData.each_index do |index|
            if index == 0
                row = (mapData[index].split("*"))[0].to_i()
                col = (mapData[index].split("*"))[1].to_i()
                puts("#{row}*#{col}")
                @grid = Array.new(row) { Array.new(col) }
            else
                row = mapData[index].split("")
                row.each_index do |cell_i|
                    if row[cell_i] == "-"
                        @grid[index - 1][cell_i] = Bridge.new(cell_i, index - 1)
                    else
                        @grid[index - 1][cell_i] = Isle.new(cell_i, index - 1, row[cell_i].to_i())
                    end
                end
            end
        end

        @grid.each_index do |i|
            @grid[i].each_index do |j|
                left = nil
                top = nil
                right = nil
                bottom = nil

                if i - 1 >= 0
                    bottom = @grid[i - 1][j]
                end
                if i + 1 < @grid.size()
                    top = @grid[i + 1][j]
                end
                if j - 1 >= 0
                    left = @grid[i][j - 1]
                end
                if j + 1 < @grid[0].size()
                    right = @grid[i][j + 1]
                end

                @grid[i][j].setLinkNode(left, top, right, bottom)
            end
        end
    end

    def start
        while(self.completed? == false)
            xDep = 0
            yDep = 0
            xDest = 0
            yDest = 0

            print(self)
            print("\nSaisir les coordonnées de la case de départ :\n")
            loop do
                print("X = ")
                xDep = gets.to_i()

                break if xDep >= 0 && xDep < @grid[0].size()
            end
            loop do
                print("Y = ")
                yDep = gets.to_i()

                break if yDep >= 0 && yDep < @grid.size()
            end
            puts("Saisir les coordonnées de la case de destination :")
            loop do
                print("X = ")
                xDest = gets.to_i()

                break if xDest >= 0 && xDest < @grid[0].size()
            end
            loop do
                print("Y = ")
                yDest = gets.to_i()

                break if yDest >= 0 && yDest < @grid.size()
            end

            if @grid[yDep][xDep].class() == Isle
                if @grid[yDep][xDep].linkStart(xDest, yDest) == false
                    print("Le pont n\'a pas pu être créer\n\n")
                end
            else
                print("La cellule de départ n\'est pas une ile\n\n")
            end
            print("##################################################\n\n")
        end
        print(self)

        print("\n\n Vous avez gagné !!!\n")
    end

    def completed?
        @grid.each_index do |index|
            @grid[index].each_index do |cell_i|
                if @grid[index][cell_i].class == Isle && @grid[index][cell_i].fullConnected? == false
                    return false
                end
            end
        end
        return true
    end

    def to_s
        chaine = "   |"
        @grid[0].each_index do |index|
            chaine += "%2d |" % [index]
        end
        chaine += "\n"
        @grid[0].each_index do |index|
            chaine += "----"
        end
        chaine += "----\n"

        @grid.each_index do |index|
            chaine += "%2d |" % [index]
            @grid[index].each_index do |cell_i|
                chaine += @grid[index][cell_i].to_s() + " "
            end
            chaine += "\n"
        end
        return chaine
    end
end

game = Hashi.new("map.txt");
game.start()