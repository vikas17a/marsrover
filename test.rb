require "minitest/autorun"
require "./marsrover"

class TestMeme < Minitest::Test
  def setup
    @pletaue = Pletaue.new(5,5)
    @rover = Rover.new(4, 2, 'N', @pletaue)
    @nav = Navigate.new
  end

  def test_if_platue_intialize
    assert_equal 5, @pletaue.plot_x
    assert_equal 5, @pletaue.plot_y

    assert_raises(ArgumentError) do
      @pletaue = Pletaue.new(-3,-4)
    end

    assert_raises(ArgumentError) do
      @pletaue = Pletaue.new(-3, 4)
    end

    assert_raises(ArgumentError) do
      @pletaue = Pletaue.new('E', -3)
    end

    assert_raises(ArgumentError) do
      @pletaue = Pletaue.new(3, '2')
    end

    assert_raises(ArgumentError) do
      @pletaue = Pletaue.new(3, true)
    end

    assert_raises(ArgumentError) do
      @pletaue = Pletaue.new(3)
    end

  end

  def test_if_rover_initialize
    assert_equal 4, @rover.x
    assert_equal 2, @rover.y
    assert_equal 'N', @rover.face
    assert_equal 0, @rover.face_numeric
    assert_equal @pletaue, @rover.pletaue

    @rover.change_direction('R')
    assert_equal 'E', @rover.face
    assert_equal 3, @rover.face_numeric

    assert_equal 5, @rover.move
    assert_equal 5, @rover.x
    assert_equal 2, @rover.y
    assert_equal 'E', @rover.face
    assert_equal 3, @rover.face_numeric

    #testing if we initialize rover with negative params
    assert_raises(ArgumentError) do
      @rover = Rover.new('3','32','N',@pletaue)
    end
    
    assert_raises(ArgumentError) do
      @rover = Rover.new("Q",2,'N',@pletaue)
    end
    
    assert_raises(ArgumentError) do
      @rover = Rover.new(-1,'Nw',@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(-1,2,'N',@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(1,-2,'N',@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(6,2,'N',@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(-1,-2,'N',@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(-1,2,'N',@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(1,2,'M',@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(-1,2,2,@pletaue)
    end

    assert_raises(ArgumentError) do
      @rover = Rover.new(-1,2,'S',@rover)
    end

    @rover = Rover.new(3,3,'S',@pletaue)
    assert_equal 2, @rover.move
    assert_equal 1, @rover.move
    assert_equal 0, @rover.move
      
    assert_raises(ArgumentError) do
      @rover.move
      @rover.in_boundary
    end

    assert_raises(ArgumentError) do
      @rover.change_direction('X')
    end
  end

  def test_if_navigation_works
    assert_equal "2 1 E",@nav.input_me("5 5", "0 0 N", "MRMM")
    assert_equal "2 1 S",@nav.input_me("5 5", "0 0 N", "MRMMR")
    assert_equal "5 3 S",@nav.input_me("5 5", "5 5 N", "RRMM")
    assert_equal "An error occured",@nav.input_me("5 5", "0 0 D", "MRMM")
    assert_equal "An error occured",@nav.input_me("-5 5", "0 0 N", "RMRMM")
    assert_equal "An error occured",@nav.input_me("5 5", "0 2 N", "MMMMM")
    assert_equal "An error occured",@nav.input_me("N 5", "0 0 N", "MRMM")
    assert_equal "An error occured",@nav.input_me("-5 5", "0 0e N", "M^^\e}RMM")
    assert_equal "An error occured",@nav.input_me("-55", "00eN", "M^^\e}RMM")
    assert_equal "An error occured",@nav.input_me("-55", "00eN", 24214)
    assert_equal "An error occured",@nav.input_me(2123, 12321, 323)
    assert_equal "An error occured",@nav.input_me(-123, "Test", -23)
    assert_equal "An error occured",@nav.input_me(2123, "M", 323)
    assert_equal "An error occured",@nav.input_me("-1 34", "3 3 S", "MMMLR")
    assert_equal "An error occured",@nav.input_me("23", '33N', 'MMMR')
    assert_equal "An error occured",@nav.input_me("-1 3", "0 0 N", "RRRRRMMMM")
    assert_equal "An error occured",@nav.input_me("randomvalue", "randomizeme", "MMMMRR")
    assert_equal "An error occured",@nav.input_me("test", "1 1 N", "test")

    assert_raises(ArgumentError) do
      @nav.input_me("2 2")
    end

    assert_raises(ArgumentError) do
      @nav.input_me("2 2", "23")
    end

    assert_raises(ArgumentError) do
      @nav.input_me('\]')
    end
  end

  def test_if_error_class_works
    assert_raises(ArgumentError) do
      Error.error(1)
    end
    assert_raises(ArgumentError) do
      Error.error(2)
    end
    assert_raises(ArgumentError) do
      Error.error(3)
    end
    assert_raises(ArgumentError) do
      Error.error(4)
    end
    assert_raises(RuntimeError) do
      Error.error(5)
    end
    assert_raises(RuntimeError) do
      Error.error('G')
    end
    assert_raises(RuntimeError) do
      Error.error("hello this is a string")
    end
  end

end
