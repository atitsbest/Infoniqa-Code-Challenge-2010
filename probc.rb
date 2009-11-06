
def max(a, b)
	a > b ? a : b
end

def min(a, b)
	a < b ? a : b
end

def abs(a)
	return a if a > 0
	-a
end

include Math

#input = "FFFR 4"
#input = "F 6-R 1-F 4-RFF 2-LFF 1-LFFFR 1-F 2-R 1-F 5"
input = "L 1-FR 1-FFFFFL 1-FFFFL 1-F 12-L 1-F 12-L 1-F 12-L 1-FFFFL 1-FFFFFFFFR 1-FFFR 1-FFFL 1"
#input = "FFRFLFLFFRFRFLFF 3-R 1-FFLFRFRFLFFF 3-R 1-FFFFFF 3-L 1-FFFRFLFLFRFF 2-R 1-FFFRFLFLFRFF 3-R 1-FFFFFF 1-L 1-FFRFLFLFFRFRFLFF 3-R 1-FFLFRFRFFLFLFRFF 2-L 1-FFLFRFRFFLFLFRFF 3-R 1-FFRFLFLFFRFRFLFF 2-R 1-FFRFLFLFFRFRFLFF 2-L 1-FFFFFF 3-R 1-FFFRFLFLFRFF 5-R 1-FFLFRFRFLFFF 1-L 1-FFLFRFRFFLFLFRFF 2-R 1-FFRFLFLFFRFRFLFF 2-L 1"
#input = "FFLFRFRFFLFLFRFF 5-L 1-FFFRFLFLFRFF 4-L 1-FFLFRFRFFLFLFRFF 8-L 1-FFLFRFRFFLFLFRFF 4-L 1-FFFFFF 3-R 1"

y=0
x=0

points = []


direction = 0

parts = input.split('-')

parts.each do |p|
	p =~ /([FLR]+)\s(\d+)/

	str = $1.to_s
	count = $2.to_i
	
	count.times do 
	
		str.split(//).each do |c|

			if (c == 'R')
				direction = (direction + 1) % 4
				points << {"x" => x, "y" => y}
			elsif (c == 'L') 
				direction = direction - 1
				direction = 3 if direction < 0
				points << {"x" => x, "y" => y}
			elsif (c == 'F') 
				if (direction == 0)
					y += 1
				elsif (direction == 1)
					x += 1
				elsif (direction == 2)
					y -= 1
				elsif (direction == 3)
					x -= 1
				end
				
			end
				
		end
	end
end

points << {"x" => x, "y" => y}

result = 0
		
(points.length-2).times do |i|
	p = points[i]
	pi = points[i+1]
	
	x = p["x"] + pi["x"]
	y = pi["y"] - p["y"]

	result += x*y
end

result = abs(result)/2

puts result