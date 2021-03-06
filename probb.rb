
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
#input = "L 1-FR 1-FFFFFL 1-FFFFL 1-F 12-L 1-F 12-L 1-F 12-L 1-FFFFL 1-FFFFFFFFR 1-FFFR 1-FFFL 1"
#input = "FFRFLFLFFRFRFLFF 3-R 1-FFLFRFRFLFFF 3-R 1-FFFFFF 3-L 1-FFFRFLFLFRFF 2-R 1-FFFRFLFLFRFF 3-R 1-FFFFFF 1-L 1-FFRFLFLFFRFRFLFF 3-R 1-FFLFRFRFFLFLFRFF 2-L 1-FFLFRFRFFLFLFRFF 3-R 1-FFRFLFLFFRFRFLFF 2-R 1-FFRFLFLFFRFRFLFF 2-L 1-FFFFFF 3-R 1-FFFRFLFLFRFF 5-R 1-FFLFRFRFLFFF 1-L 1-FFLFRFRFFLFLFRFF 2-R 1-FFRFLFLFFRFRFLFF 2-L 1"
#input = "FFLFRFRFFLFLFRFF 5-L 1-FFFRFLFLFRFF 4-L 1-FFLFRFRFFLFLFRFF 8-L 1-FFLFRFRFFLFLFRFF 4-L 1-FFFFFF 3-R 1"

max_x = 0
min_x = 0
max_y = 0
min_y = 0

y=0
x=0

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
			elsif (c == 'L') 
				direction = direction - 1
				direction = 3 if direction < 0
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
				
				max_x = max(max_x, x)
				max_y = max(max_y, y)

				min_x = min(min_x, x)
				min_y = min(min_y, y)
			end
				
		end
	end
end
		
width = max_x - min_x
height = max_y - min_y
result = width * height

puts result