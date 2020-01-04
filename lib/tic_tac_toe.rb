class TicTacToe
  
  # Board Representation For Reference
  #           | 0  1  2 |
  #           | 3  4  5 |
  #           | 6  7  8 |
  
  WIN_COMBINATIONS = [
    [0,1,2], # TOP ROW
    [3,4,5], # MIDDLE ROW
    [6,7,8], # BOTTOM ROW
    [0,3,6], # LEFT COLUMN
    [1,4,7], # MIDDLE COLUMN
    [2,5,8], # RIGHT COLUMN
    [0,4,8], # LEFT DIAGONAL
    [2,4,6]  # RIGHT DIAGONAL
  ]
  
  def initialize()
    @board = [" "," "," "," "," "," "," "," "," "]
  end
  
  def display_board
    idx = 0
    3.times do
      left = @board[idx]
      middle = @board[idx+1]
      right = @board[idx+2]
      puts " #{left} | #{middle} | #{right} "
      puts "-----------" unless idx == 2
      idx += 3
    end
  end
  
  def input_to_index(users_input)
    users_input.to_i - 1
  end
  
  def move(move_idx, player_token)
    @board[move_idx] = player_token
  end
  
  def position_taken?(move_idx)
    !(@board[move_idx] == " ")
  end
  
  def valid_move?(move_idx)
    result = false
    first_test= (move_idx > -1 && move_idx < 9)
    second_test = (position_taken?(move_idx) == false)
    
    if(first_test && second_test)
      result = true
    end
    result
  end
  
  def turn_count
    @board.count {|el| el !=  " "}
  end
  
  def current_player(last_idx=0)
    ((turn_count - last_idx) % 2 == 0) ? "X" : "O"
  end
  
  def turn
    puts "Please Enter A Number 1-9"
    user_input = gets.chomp
    
    # Convert User Input to Move Index Value (String => Integer)
    move_idx = input_to_index(user_input) 
    
    if valid_move?(move_idx)
      move(move_idx,current_player)
      display_board
    else
      turn
    end
  end
  
  def won?
    array = get_moves
    WIN_COMBINATIONS.each do |combo_set|
      test = combo_set.all?{|el| array.include?(el)}
      if test
        return combo_set
      end
    end
    false
  end
  
  def full?
    turn_count == 9
  end
  
  
  def draw?
    result = false
    if !won? && full?
      result = true
    end
    result
  end
  
  def over?
    result = false
    if won? || draw?
      result = true
    end
    result
  end
  
  def winner
    if won?
      return ((turn_count-1) % 2 == 0) ? "X" : "O"
    end
    nil
  end
  
  def play

    until over? do
      turn
    end
    
    if won?
      puts "Congratulations #{winner}!"
    end
    
    if draw?
      puts "Cat's Game!"
    end
    
  end
  
  private
  
  def get_moves
    result = []
    player_token = ((turn_count - 1) % 2 == 0) ? "X" : "O"
    @board.each_with_index do |el,idx|
      result << idx if el == player_token
    end
    result
  end
 end