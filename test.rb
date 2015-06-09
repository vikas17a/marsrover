require "minitest/autorun"
require "./marsrover"

class TestMeme < Minitest::Test
  def setup
    @direction = Direction.new
    @move = Move.new
    @start = Start.new
  end

  def test_if_direction_can_work
    assert_equal "W", @direction.changeDirection('L','N')
    assert_equal "S", @direction.changeDirection('L','W')
    assert_equal "E", @direction.changeDirection('L','S')
    assert_equal "N", @direction.changeDirection('L','E')
    assert_equal "E", @direction.changeDirection('R','N')
    assert_equal "S", @direction.changeDirection('R','E')
    assert_equal "W", @direction.changeDirection('R','S')
    assert_equal "N", @direction.changeDirection('R','W')
  end

  def test_if_move_can_work
    assert_equal [1,2], @move.move('N',1,1)
    assert_equal [2,2], @move.move('E',1,2)
    assert_equal [2,1], @move.move('E',1,1)
    assert_equal [1,1], @move.move('N',1,0)
    assert_equal [3,3], @move.move('N',3,2)
    assert_equal [1,2], @move.move('W',2,2)
    assert_equal [3,3], @move.move('S',3,4)
    assert_equal [3,1], @move.move('E',2,1)
    assert_equal [2,1], @move.move('E',1,1)
  end

  def test_if_start_can_work
    assert_equal "1 3 N", @start.inputMe("5 5", "1 2 N", "LMLMLMLMM")
    assert_equal "5 1 E", @start.inputMe("5 5", "3 3 E", "MMRMMRMRRM")
  end
end
