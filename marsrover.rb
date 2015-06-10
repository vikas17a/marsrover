class Error
	def self.error(no)
		case no
		when 1
			raise ArgumentError, "Invalid arguments for rover"
		when 2
			raise ArgumentError, "Invalid rotation or move"
		when 3
			raise ArgumentError, "Invalid cordinates for pletaue"
		when 4
			raise ArgumentError, "Invalid command for rover"
		else
			raise "Something went wrong"
		end
	end
end


class Rover
	attr_reader :x
	attr_reader :y
	attr_reader :face
	attr_reader :face_numeric
	attr_reader :pletaue
	attr_reader :valid_direction
	attr_reader :direction_map_numeric
	
	def initialize(x,y,face, pletaue)
		@valid_direction = ['N', 'W', 'S' ,'E']
		@direction_map_numeric = {"N" => 0, "W" => 1, "S" => 2, "E" => 3}
		if !([x,y].all? {|i| i.is_a?(Integer)}) || x < 0 || y < 0 || !(@valid_direction.include? face) || x > pletaue.plot_x || y > pletaue.plot_y || @pletaue.is_a?(Pletaue)
			Error.error(1)
		end
		@x =x
		@y =y
		@face =face
		@face_numeric = @direction_map_numeric[face]
		@pletaue = pletaue
	end
	def change_direction(rotation)
		case rotation
		when 'R'
			@face_numeric = (@face_numeric - 1)%4
			@face = @valid_direction[@face_numeric]
		when 'L'
			@face_numeric = (@face_numeric + 1)%4
			@face = @valid_direction[@face_numeric]
		else
			Error.error(2)
		end
	end

	def in_boundary
		if @x < 0 || @y < 0 || @x > @pletaue.plot_x || @y > @pletaue.plot_y
			Error.error(2)
		end
	end

	def move
		case @face
		when 'N'
			@y += 1
		when 'E'
			@x += 1
		when 'W'
			@x -= 1
		when 'S'
			@y -= 1
		else
			Error.error(2)
		end
	end
end

class Pletaue
	attr_reader :plot_x
	attr_reader :plot_y
	def initialize(x,y)
		if !([x,y].all? {|i| i.is_a?(Integer)}) || x <= 0 || y <=0
			Error.error(3)
		end
		@plot_x = x
		@plot_y = y
	end
end

class Navigate
	def input_me(ppos, position, user_in)
		begin
			pletaue = ppos.split(" ")
			p = Pletaue.new(pletaue[0].to_i, pletaue[1].to_i)
			init_state = position.split(" ")
			rover = Rover.new(init_state[0].to_i, init_state[1].to_i, init_state[2], p)
			user_in.split("").each do |c|
				if ['R', 'L'].include? c
					rover.change_direction(c)
				elsif ['M'].include? c
					rover.move
					rover.in_boundary
				else
					Error.error(4)
				end
			end
			"#{rover.x} #{rover.y} #{rover.face}"
		rescue
			"An error occured"
		end	
	end
end