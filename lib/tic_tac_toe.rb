require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

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

    def move(index, token = "X")
        @board[index] = token
    end
    
    def position_taken?(index)
        if @board[index] == " "
            return false
        else
            return true
        end 
    end

    def valid_move?(index)
        if position_taken?(index) == true
            return false
        end

        if index > 8 || index < 0
            return false
        end

        true
    end 

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"  
    end

    def turn
        puts "Please choose a number between 1 and 9"
        user_input = gets
        index = input_to_index(user_input)
        if valid_move?(index) == true
            token = current_player
            move(index, token)
            display_board
        else
            turn
        end
    end 

    def won?
        WIN_COMBINATIONS.find do | combo |
            combo.all?{| index | @board[index] == "X"} || 
            combo.all?{| index | @board[index] == "O"}
        end 
    end

    def full?
        @board.all?{| space | space != " "}
    end

    def draw?
        full? && !won?
    end
    
    def over?
        won? || draw?
    end

    def winner
        if won?
          index = won?[1]
          @board[index]
        else
            nil
        end 
    end

    def play
        while !over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end


end 

