class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    #we're going to ask players for 1-9, but index is 0-8
    !position_taken?(index) && index.between?(0,8)
  end

  def turn_count
    #count takes a block as an arg
    @board.count{|square| square != " "}
  end

  def current_player
    #x goes on even, o goes on odd turns
    turn_count.even? ? "X" : "O"
  end 

  #ask for input
  #get input
  #chomp takes off new line from input
  #we already made input_to_index earlier, which is an integer
  #translate input => index
  #if index is valid, make the move & show the board
  def turn
    puts "Please enter a number (1-9):"
    index = input_to_index(gets.chomp)
    if valid_move?(index)
      move(index, current_player)
      display_board
    #if not, restart the turn
    else 
      turn
    end
  end 
  
  def won?
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
      return combo
      end
    end
  end

  def full?
    @board.all?{|square| square != " " }
  end 

  def draw?
    full? && !won?
  end

  def over?
    won? || draw? 
  end

  def winner
    if combo = won?
      @board[combo[0]]
    end
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end

end