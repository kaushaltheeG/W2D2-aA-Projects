class GuessingGame

    attr_reader :num_attempts

    def initialize(min, max)
        @min = min
        @max = max
        @secret_num = rand(min..max)
        @num_attempts = 0
        @game_over = false
    end

    def game_over?
        @game_over
    end

    def check_num(num)
        @num_attempts += 1

        @game_over = true if num == @secret_num
        p  @game_over? 'you win' : num > @secret_num ? 'too big' : 'too small'
    end
    
    def ask_user
        p 'enter number'
       input = gets.chomp
       check_num(input.to_i)
    end

end
