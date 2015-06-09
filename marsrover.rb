class Rover
	attr_reader :x
	attr_reader :y
	attr_reader :face
	attr_reader :plot_x
	attr_reader :plot_y
	def initialize(x,y,face, plot_x, plot_y)
		@x =x
		@y =y
		@face =face
		@plot_x = plot_x
		@plot_y = plot_y
	end
	def setCordinates(x,y)
		if(x <= @plot_x && y <= @plot_y && x >= 0 && y >= 0)
			@x = x
			@y = y
		end
	end
	def setFace(face)
		@face = face
	end
end
class Direction
	attr_reader :new_direction
	def changeDirection(rotation, intial_facing)
		case rotation
		when 'L'
			case intial_facing
			when 'N'
				@new_direction = 'W'
			when 'W'
				@new_direction = 'S'
			when 'S'
				@new_direction = 'E'
			when 'E'
				@new_direction = 'N'
			else
				puts "Error no initial facing direction added"
			end
		when 'R'
			case intial_facing
			when 'N'
				@new_direction = 'E'
			when 'E'
				@new_direction = 'S'
			when 'S'
				@new_direction = 'W'
			when 'W'
				@new_direction = 'N'
			else
				puts "Error no intial facing direction added"
			end
		else
			puts "Error no rotation direction added"
		end  
		@new_direction
	end
end

class Move
	attr_reader :x
	attr_reader :y
	def move(initial_facing,x,y)
		@x=x
		@y=y
		case initial_facing
		when 'N'
			@x = x
			@y += 1
		when 'E'
			@x += 1
			@y = y
		when 'W'
			@x -= 1
			@y = y
		when 'S'
			@x = x
			@y -= 1
		else
			puts "Error no initial facing direction added"
		end
		[@x, @y]
	end
end


class Start
	def inputMe(one, two, user_in)
		#user_in = gets.chomp
		dim = one.split(" ")
		#user_in = gets.chomp
		init_state = two.split(" ")
		rover = Rover.new(init_state[0].to_i, init_state[1].to_i, init_state[2], dim[0].to_i, dim[1].to_i)
		#user_in = gets.chomp
		direction = Direction.new
		mov = Move.new
		user_in.split("").each do |c|
			if ['R', 'L'].include? c
				new_direction = direction.changeDirection(c, rover.face)
				rover.setFace(new_direction)
			elsif ['M'].include? c
				x, y = mov.move(rover.face, rover.x, rover.y)
				rover.setCordinates(x,y)
			end
		end
		"#{rover.x} #{rover.y} #{rover.face}"
	end
end