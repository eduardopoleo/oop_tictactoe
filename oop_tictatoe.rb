class Player
	attr_accessor :moves
	
	def initialize
		@moves=[]
	end
	
end

class Human < Player
	def play_move(board)
		puts "Choose your move wisely:"
		begin
			choice=gets.chomp.to_i

			unless board[choice] == " "
				puts "Please select an available move"
			end

		end until board[choice] == " "
		board[choice] = "X"
		self.moves << choice 
	end
end

class Computer < Player
	def play_move(board)
		choice = board.select{|k,v| v == " "}.keys.sample
		board[choice] = "O"
		self.moves << choice
	end
end

class Board
	attr_accessor :board_state
	
	def initialize
		@board_state = {}
		(1..9).each {|position| @board_state[position] =" "}  
	end
	
	def draw_board
		system('clear')
		puts " #{board_state[1]} | #{board_state[2]} | #{board_state[3]}"
		puts "---+---+---"
		puts " #{board_state[4]} | #{board_state[5]} | #{board_state[6]}"
		puts "---+---+---"
		puts " #{board_state[7]} | #{board_state[8]} | #{board_state[9]}"
		puts " "
	end
end

class Game
	attr_accessor :human, :computer, :board
	WINNING_LINES=[[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

	def initialize
		@human = Human.new
		@computer = Computer.new
		@board = Board.new
	end

	def winning_condition(player_moves)
		if WINNING_LINES.any?{|line| (line-player_moves).empty?}
			true
		end
	end

	def play_again?
		puts "Do you want to play again? (y/n)"
		begin
			choice=gets.chomp.downcase
			
			if choice == "y"
				new_game = Game.new.play
			elsif choice == "n"
				puts "GoodBye!"
			end

			unless choice == "y" || choice == "n"
				puts "Please give a valid answer!"
			end
		end until choice == "y" || choice == "n"
	end

	def play
		begin
			board.draw_board
			human.play_move(board.board_state)
			if self.winning_condition(human.moves)
				board.draw_board
				puts "You won!"
				break
			end

			computer.play_move(board.board_state)
			if self.winning_condition(computer.moves)
				board.draw_board
				puts "You lost!"
				break
			end

			if (board.board_state.any?{|k,v| board.board_state[k]==" "} == false)
				board.draw_board
				puts "It's a draw"
			end

		end until (board.board_state.any?{|k,v| board.board_state[k]==" "} == false)
		self.play_again?
	end
end

game=Game.new.play