require_relative "room"

class Hotel
    attr_reader :rooms

    def initialize(name, room_and_capacity)
        @name = name
        @rooms = Hash.new 

        room_and_capacity.each_pair do |key, val|
            @rooms[key] = Room.new(val)
        end
    end

    def name
        name_arr = @name.split(' ')
        name_arr.each.with_index {|word, i| name_arr[i] = word.capitalize}
        name_arr.join(' ')
    end

    def room_exists?(room)
        return true if @rooms[room]
        false
    end

    def check_in(person, room)
        return p 'sorry, room does not exist' if !self.room_exists?(room)
        is_added = @rooms[room].add_occupant(person) #can only use add_occupants because the hash value is instance of Room
        p is_added ? 'check in successful' : 'sorry, room is full'
    end

    def has_vacancy?
        @rooms.each_value {|val| return true if !val.full?}
        false
    end

    def list_rooms
        @rooms.each_pair {|key, val| puts "#{key}: #{val.available_space}"} #works only with put and not p
    end

end

