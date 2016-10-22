class Board

	@@winning_scenarios = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

	def initialize
		@board_array = []
		@current_turn = 1
		9.times {|i| @board_array[i]=(i+1).to_s}
	end

	def display_board
		display_string = ""
		@board_array.each_with_index do |data, index|
			display_string << "-------------\n|" if index % 3 == 0 
			display_string << " #{@board_array[index]} |"
			display_string << "\n" if index % 3 == 2 
		end
		display_string << "-------------\n"
		puts display_string
	end


	#def display_board
	#	puts "-------------\n| #{@board_array[0]} | #{@board_array[1]} | #{@board_array[2]} |\n"
	#	puts "-------------\n| #{@board_array[3]} | #{@board_array[4]} | #{@board_array[5]} |\n"
	#	puts "-------------\n| #{@board_array[6]} | #{@board_array[7]} | #{@board_array[8]} |\n"
	#end

	def pick_letter
		puts "Please choose 'X' or 'O'"
		@player_one_letter = gets.chomp.upcase
		while @player_one_letter != 'X' && @player_one_letter != 'O'
			puts "Invalid character, please choose 'X' or 'O'"
			@player_one_letter = gets.chomp.upcase
		end
		@player_two_letter = @player_one_letter == 'X' ? 'O' : 'X'
	end

	def turn
		@current_player = @current_turn % 2 == 1 ? 1.to_s : 2.to_s
		@current_letter = @current_player.to_i == 1 ? @player_one_letter : @player_two_letter
		puts "Player #{@current_player}'s turn, please enter a number:"
		player_choice = gets.chomp.to_i
		while @board_array[player_choice - 1] == player_choice - 1 && player_choice != 1..9
			puts "Invalid choice. Player #{current_player.to_s}'s turn, please enter a number:"
			player_choice = gets.chomp.to_i
		end
		@board_array[player_choice - 1] = @current_letter
		@current_turn += 1
	end

	def game_over?
		if @current_turn > 9
			puts "The game is a tie!"
			display_board
			return true
		end

		@@winning_scenarios.each do |winning_array|
			win_counter = 0
			winning_array.each do |index|
				win_counter += 1 if @board_array[index] == @current_letter
			end
			if win_counter == 3
				puts "Player #{@current_player} wins!"
				display_board
				return true
			end
		end

		return false
	end
end


game = Board.new
game.pick_letter
while(game.game_over? == false)
	game.display_board
	game.turn
end