
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
input = "FFLFRFRFFLFLFRFF 5-L 1-FFFRFLFLFRFF 4-L 1-FFLFRFRFFLFLFRFF 8-L 1-FFLFRFRFFLFLFRFF 4-L 1-FFFFFF 3-R 1"

max_x = 0
min_x = 0
max_y = 0
min_y = 0

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

				max_x = max(max_x, x)
				max_y = max(max_y, y)

				min_x = min(min_x, x)
				min_y = min(min_y, y)
			end
				
		end
	end
end

points << {"x" => x, "y" => y}
#puts points

def contains_point?(points, x, y)
  contains_point = false
  i = -1
  j = points.size - 1
  while (i += 1) < points.size
    a_point_on_polygon = points[i]
    trailing_point_on_polygon = points[j]
    if point_is_between_the_ys_of_the_line_segment?(x,y, a_point_on_polygon, trailing_point_on_polygon)
      if ray_crosses_through_line_segment?(x,y, a_point_on_polygon, trailing_point_on_polygon)
        contains_point = !contains_point
      end
    end
    j = i
  end
  return contains_point
end

def point_is_between_the_ys_of_the_line_segment?(x,y, a_point_on_polygon, trailing_point_on_polygon)
  (a_point_on_polygon["y"] <= y && y < trailing_point_on_polygon["y"]) || 
  (trailing_point_on_polygon["y"] <= y && y < a_point_on_polygon["y"])
end

def ray_crosses_through_line_segment?(x,y, a_point_on_polygon, trailing_point_on_polygon)
  (x < (trailing_point_on_polygon["x"] - a_point_on_polygon["x"]) * (y - a_point_on_polygon["y"]) / 
             (trailing_point_on_polygon["y"] - a_point_on_polygon["y"]) + a_point_on_polygon["x"])
end


result = 0
		
(min_x..max_x).each do |ix|
	(min_y..max_y).each do |iy|
		unless contains_point?(points, ix, iy)
			
			inc = false;
			(iy..max_y).each do |yy|
				if contains_point?(points, ix, yy)
					(min_y..iy).each do |yyy|
						if contains_point?(points, ix, yyy)
							inc = true
						end
					end
				end
			end	

			if inc
				result += 1
			else

				(ix..max_x).each do |xx|
					if contains_point?(points, xx, iy)
						(min_x..ix).each do |xxx|
							if contains_point?(points, xxx, iy)
								inc = true
							end
						end
					end
				end	

				result += 1 if inc
			
			end
			
		end
	end
end
		

puts result