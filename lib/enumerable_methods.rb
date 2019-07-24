module Enumerable
    def my_each                                         #does what .each does
        if self.class == Array                          #checks class of receiver
            for i in 0..self.length-1 do                #iterates through length of array
                yield(self[i])                          #yields to block on each iteration
            end 
        elsif self.class == Hash
            for i in 0..self.length-1 do
                yield(self.keys[i], self.values[i])          #yields to block passing 2 arguments as parameters
            end
        end
    end



    def my_each_with_index                                  #iterates through receiver and yields to the block passing 2 parameters
        if self.class == Array
            for i in 0..self.length-1 do
                yield(self[i], i)              #adds result of array to new_array
            end
        elsif self.class == Hash
            for i in 0..self.length do
                yield(key[i], i)
            end
        end
    end


    
    def my_select                                       #iterates through and yields to block which then chooses based on block and passes to new array
        if self.class == Array
            new_array = [] 
            self.my_each do |value|                     #use my_each method
                if yield(value)                         #depends on what happens in the block. 
                    new_array << value                  #adds value to new_array if the value returned true in the block yield
                end
            end
            new_array
        elsif self.class == Hash
            new_hash = {}
            self.my_each do |key, value|
                if yield(key, value)                    #another way of saying: if the block returns true
                    new_hash[key] = value
                end
            end
            new_hash
        end
    end



    def my_all?                                         #iterate through and, if everything evaluates to true, it returns true
        if self.class == Array
            self.my_each do |value|
                if !yield(value)
                    return false
                end
            end
        elsif self.class == Hash
            self.my_each do |key, value|
                if !yield(key, value)                     #another way of saying, if the block returns false
                    return false                          #if one false is found, then false is returned and method execution stops
                end
            end
        end                                                 
        true     
    end                                                     #if none are found then the default (true) is returned



    def my_any?                                             #iterates through and returns true if ANY iteration returns true
        if self.class == Array
            self.my_each do |value|
                if yield(value)
                    return true
                end
            end
        elsif self.class == Hash
            self.my_each do |key, value|
                if yield(key, value)                        #if block yield is true then true is returned
                    return true
                end
            end
        end
        false                                               #this is the default setting
    end



    def my_none?                                        #method checks if the object contains anything specified in the block
        if self.class == Array
            self.my_each do |value|
                if yield(value)
                    return false
                end
            end
        elsif self.class == Hash 
            self.my_each do |key, value|
                if yield(key, value)                    #if the block evaluates to true then the method returns false
                    return false
                end
            end
        end
        true                                            #default value. This is returned if block never returns true
    end          
    

    
    def my_count                                        #number of values equal to given argument are counted
        if self.class == Array
            count = 0                                   #shows how many times (in this case) the yield has returned true
            self.my_each do |value|
                if yield(value)                         #adds to the count if the block returns true
                count += 1                      
                end
            end
        elsif self.class == Hash
            self.my_each do |key, value|
                if yield(key, value)
                    count += 1
                end
            end
        end
        count
    end



    def my_map(proc= nil)                                          #returns a new array containing items meeting block criteria
        if self.class == Array
            new_array = []
            self.my_each do |value|                     #iterates through input array
                if proc = nil
                    new_array << proc.call(value)              #adds result of block to the new_array    
                else
                    new_array << yield(value)
                end
            end
        end
        if self.class == Hash
            new_hash = {}
            self.my_each do |key, value|
                if yield(key, value)
                    new_hash[key] = value
                end
            end
        end
    end





    def my_inject(x)                                        #??????????????????????????????????????????
        total = x
        if self.class == Array
            self.my_each do |value|
                total = yield(total, value)
            end
        elsif self.class == Hash
            self.my_each do |key, value|
                total = yield(total, value)
            end
        else
        end
    total
  end




end

my_array = [2, 4, 6, 8, 10, 11]
my_hash = {"dog" => 2, "cat" => 4}

# my_array.my_each { |element| puts element}          #inline
# my_array.my_all? do |element|                       #multi-line
#     element % 2 == 0
# end
# my_array.my_all? { |value| value % 2 == 0}
# my_array.my_none? { |value| value > 11}
# my_array.my_count { |value| value % 2 == 0}
my_array.my_map { |value| value * 2 }
my_hash.my_map { |key, value| value * 2}