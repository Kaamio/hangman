require "yaml"

class Game
	attr_accessor :correct_word
	attr_accessor :letter
	attr_accessor :test_game
	attr_accessor :word_so_far
	attr_accessor :wrong_quesses
	

def initialize
	@word_so_far=""
	@wrong_quesses = 0
end

def get_words
	
	array_of_words = File.readlines("words.txt")
	array_of_correct_words = []
	array_of_words.each do |f| 
		if f.length > 5 && f.length < 12
	array_of_correct_words.push(f)
end
end	
	
	@correct_word = array_of_correct_words.sample.downcase
	@word_so_far = []
	@correct_word.length.times { @word_so_far.push("_") }
	puts @correct_word
	correct_word.length.times  { print "_" }
	@word_so_far.pop
	puts "" 
	end
	

def quess
alphabet = ("a".."z").to_a

until @wrong_quesses > 4

	
	letter = ""
	loop do 
	puts "Quess a letter! Type 123 to save game or type  exit to exit"
	letter = gets.chomp
	break if alphabet.include?(letter) || letter =="123" || letter == "exit"
	puts "Please enter a letter between A and Z"
end

if letter == "123"
saveGame
elsif letter == "exit"
exit	
else
checkletter(letter)
check_victory
end 

end

end


def saveGame
			
		data = @word_so_far.to_a
		File.open("nameofsave.txt", "w") do |s|
		s.puts self.to_yaml	

		
		puts "Game saved"
	end
end




def checkletter(letter)
	
	correct_array = @correct_word.scan /\w/

	if correct_array.include?(letter) == false
		puts "That letter is not in the word!"
		@wrong_quesses +=1		
	end

	for i in 0..(correct_array.length-1)	 
		if correct_array[i] == letter			
			@word_so_far[i] = letter
			check_victory			
		end
		
	end
	print @word_so_far.join
puts ""
end			


def check_victory
options = ["y", "n"]
answer = ""
	if @wrong_quesses > 4
	puts "Game over! You were unable to solve the word!"
elsif @word_so_far.include?("_") == false
	puts "You did it! The correct word was #{@correct_word}"
		loop do
		puts "Play again? y/n"
		answer = gets.chomp	
		break if options.include?(answer)
		puts "Please type y or n"
		end
		if answer == "n"
			exit
		else
			self.get_words

		end
		end	
	end	
end	

def loadgame
	options = ["y", "n"]
	answer = ""
	loop do
		puts "Do you want to load previous game? y/n"
		answer = gets.chomp	
		break if options.include?(answer)
		puts "Please type y or n"
		end	
	if answer == "y"
	loaded_game = YAML.load_file("nameofsave.txt")
	puts "The word you are quessing is #{loaded_game.word_so_far}"	
	loaded_game.quess
	end
end



puts "Welcome to HaNgMan! Quess the letters in the word one by one!"
loadgame
test_game = Game.new
test_game.get_words
test_game.quess

